# frozen_string_literal: true

require 'csv'
require_relative 'nkj/version'
require_relative 'nkj/range_table'

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

    def level1?(str)
      level1_range_table = RangeTable.new((0x3021..0x4F53))
      encode(str).each_grapheme_cluster do |char|
        cp = 'U+' + char.codepoints.map { |p| format('%04X', p) }.join('+')
        return false unless level1_range_table.include?(mapping[cp])
      end

      true
    end

    def level2?(str)
      level2_range_table = RangeTable.new((0x5021..0x7426))
      encode(str).each_grapheme_cluster do |char|
        cp = 'U+' + char.codepoints.map { |p| format('%04X', p) }.join('+')
        return false unless level2_range_table.include?(mapping[cp])
      end

      true
    end

    def level3?(str)
      level3_range_table = RangeTable.new(
        (0x2E21..0x2F7E),
        (0x4F54..0x4F7E),
        (0x7427..0x7E7E)
      )
      encode(str).each_grapheme_cluster do |char|
        cp = 'U+' + char.codepoints.map { |p| format('%04X', p) }.join('+')
        return false unless level3_range_table.include?(mapping[cp])
      end

      true
    end

    def level4?(str)
      level4_range_table = RangeTable.new((0xA1A1..0xFEF6))
      encode(str).each_grapheme_cluster do |char|
        cp = 'U+' + char.codepoints.map { |p| format('%04X', p) }.join('+')
        return false unless level4_range_table.include?(mapping[cp])
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
