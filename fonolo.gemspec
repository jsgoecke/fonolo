Gem::Specification.new do |s|
  s.name = "fonolo"
  s.version = "0.1.1"
  s.summary = "Ruby Library for Fonolo"
  s.description = "Ruby Library for consuming the Fonolo web services for deep dialing"
  s.authors = ["Jason Goecke"]
  s.email = ["jason@goecke.net"]
 
  s.files = ["lib/fonolo.rb", "LICENSE", "README.textile", "fonolo.gemspec", "test/test_fonolo.rb"]
  s.require_paths = ["lib"]
 
  s.add_dependency("json_pure", ">=", "1.1.2")
end