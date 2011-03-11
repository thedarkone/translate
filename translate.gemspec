Gem::Specification.new do |gem|
  gem.name    = 'translate'
  gem.version = '1.0.0'
  gem.date    = Date.today.to_s

  gem.summary = "Translates stuff"
  gem.description = "Trough a webinterface"

  gem.authors  = ['Peter']
  gem.email    = 'info@80beans.com.com'
  gem.homepage = 'http://github.com/80beans/translate'

  gem.add_dependency('rake')
  #gem.add_development_dependency('rspec', [">= 2.0.0"])

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{lib,tasks,views,spec}/**/*', 'README*', 'MIT-LICENSE*'] & `git ls-files -z`.split("\0")
end