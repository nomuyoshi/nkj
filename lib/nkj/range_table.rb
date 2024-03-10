# frozen_string_literal: true

module NKJ
  class RangeTable
    attr_reader :ranges

    def initialize(*ranges)
      @ranges = ranges
    end

    def include?(value)
      ranges.any? { |r| r.include?(value) }
    end
  end
end
