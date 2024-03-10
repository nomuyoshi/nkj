# frozen_string_literal: true

require 'csv'
require 'yaml'
require 'open-uri'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'generate unicode2jisx0213.yml'
task :generate_unicode2jisx0213 do
  uri = 'https://x0213.org/codetable/jisx0213-2004-8bit-std.txt'
  file = OpenURI.open_uri(uri, 'r', &:read)

  mapping = {}
  CSV.parse(file, col_sep: "\t", skip_lines: /\A##/).each do |row|
    unicode_point = row[1]
    next if unicode_point.nil?

    jis_code_point = Integer(row[0])
    mapping[unicode_point] = jis_code_point
  end

  YAML.dump(mapping, File.open('./source/unicode2jisx0213.yml', 'w'))
end
