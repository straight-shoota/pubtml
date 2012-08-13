require File.expand_path("../lib/pubtml/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pubtml'
  s.version     = Pubtml::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2012-08-11'
  s.summary     = "Pubtml"
  s.description = "HTML authoring and publication"
  s.authors     = ["Johannes Müller"]
  s.email       = 'johannes.mueller@smj-fulda.org'
  s.files       = Dir["*.md", "lib/**/{*,.[a-z]*}", "bin/**/*"]
  s.homepage    = ''
  s.require_path = 'lib'
  s.executables = ["pubtml"]
end
