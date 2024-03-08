# frozen_string_literal: true

require 'csv'
require_relative 'nkj/version'

module NKJ
  class Error < StandardError; end
  class << self
    def jisx0213?(str)
      encode(str).each_grapheme_cluster do |char|
        cp = 'U+' + char.codepoints.map { |p| format('%04X', p) }.join('+')
        return false if mapping[cp].nil?
      end

      true
    end

    private

    def mapping
      @mapping ||= load_mapping
    end

    def load_mapping
      tsv = CSV.read('./source/jisx0213-2004-8bit-std.txt', col_sep: "\t", skip_lines: /\A##/)
      mapping = {}
      tsv.each do |row|
        unicode_point = row[1]
        next if unicode_point.nil?

        # unicode_point = Integer(row[1].gsub('U+', '0x'))
        jis_code_point = Integer(row[0])
        mapping[unicode_point] = jis_code_point
      end

      mapping
    end

    def encode(str)
      return str if str.encoding == Encoding::UTF_8

      str.encode(Encoding::UTF_8)
    end
  end
end
