require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color --format progress']
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'translate-rails3'
    gem.summary = %Q{Newsdesk translate plugin for Rails 3}
    gem.description = <<EOF
This plugin provides a web interface for translating Rails I18n texts
(requires Rails 3.0 or higher) from one locale to another.
The plugin has been tested only with the simple I18n backend that ships
with Rails.
I18n texts are read from and written to YAML files under config/locales.

This gem is a fork of the original https://github.com/mynewsdesk/translate
and also includes work from this fork: https://github.com/milann/translate
EOF
    gem.email = 'romanbsd@yahoo.com'
    gem.homepage = 'https://github.com/romanbsd/translate'
    gem.authors = ['Peter Marklund', 'Milan Novota', 'Roman Shterenzon']
    gem.add_dependency 'ya2yaml', '~> 0.30' # For UTF-8 support in YAML
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
end
