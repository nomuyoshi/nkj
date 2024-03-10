# frozen_string_literal: true

require 'yaml'

module NKJ
  class Unicode2JISMapping
    DATA = YAML.load_file(File.expand_path('../../source/unicode2jisx0213.yml', __dir__)).freeze

    private_constant :DATA
    class << self
      def fetch(unicode_point)
        DATA[unicode_point]
      end

      def exists?(unicode_point)
        DATA.key?(unicode_point)
      end
    end
  end
end
