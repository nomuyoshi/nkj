# frozen_string_literal: true

require 'csv'
require_relative 'nkj/version'
require_relative 'nkj/range_table'
require_relative 'nkj/unicode2jis_mapping'

module NKJ
  class Error < StandardError; end
  class << self
    def jisx0213?(str)
      each_grapheme_codepoint(encode(str)) do |cp|
        return false unless Unicode2JISMapping.exists?(cp)
      end

      true
    end

    def level1?(str)
      level1_range_table = RangeTable.new((0x3021..0x4F53))
      each_grapheme_codepoint(encode(str)) do |cp|
        jis_cp = Unicode2JISMapping.fetch(cp)
        return false unless level1_range_table.include?(jis_cp)
      end

      true
    end

    def level2?(str)
      level2_range_table = RangeTable.new((0x5021..0x7426))
      each_grapheme_codepoint(encode(str)) do |cp|
        jis_cp = Unicode2JISMapping.fetch(cp)
        return false unless level2_range_table.include?(jis_cp)
      end

      true
    end

    def level3?(str)
      level3_range_table = RangeTable.new((0x2E21..0x2F7E), (0x4F54..0x4F7E), (0x7427..0x7E7E))
      each_grapheme_codepoint(encode(str)) do |cp|
        jis_cp = Unicode2JISMapping.fetch(cp)
        return false unless level3_range_table.include?(jis_cp)
      end

      true
    end

    def level4?(str)
      level4_range_table = RangeTable.new((0xA1A1..0xFEF6))
      each_grapheme_codepoint(encode(str)) do |cp|
        jis_cp = Unicode2JISMapping.fetch(cp)
        return false unless level4_range_table.include?(jis_cp)
      end

      true
    end

    private

    def each_grapheme_codepoint(str)
      str.each_grapheme_cluster do |char|
        cp = "U+#{char.codepoints.map { |p| format('%04X', p) }.join('+')}"

        yield(cp)
      end
    end

    def encode(str)
      return str if str.encoding == Encoding::UTF_8

      str.encode(Encoding::UTF_8)
    end
  end
end
