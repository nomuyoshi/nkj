# frozen_string_literal: true

require_relative 'lib/nkj/version'

Gem::Specification.new do |spec|
  spec.name = 'nkj'
  spec.version = Nkj::VERSION
  spec.authors = ['nomuyoshi']

  spec.summary = 'NKJ is a library for identifying JIS X 0213 characters.'
  spec.description = 'NKJ is a library for identifying JIS X 0213 characters.'
  spec.homepage = 'https://github.com/nomuyoshi/nkj'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = 'https://github.com/nomuyoshi/nkj'
  spec.metadata['source_code_uri'] = 'https://github.com/nomuyoshi/nkj'
  spec.metadata['changelog_uri'] = 'https://github.com/nomuyoshi/nkj/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'csv', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.62'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
