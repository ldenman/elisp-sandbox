# -*- encoding: utf-8 -*-
# stub: subprocess 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "subprocess"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Carl Jackson", "Evan Broder", "Nelson Elhage", "Andy Brody", "Andreas Fuchs"]
  s.date = "2016-08-17"
  s.description = "Control and communicate with spawned processes"
  s.email = ["carl@stripe.com", "evan@stripe.com", "nelhage@stripe.com", "andy@stripe.com", "asf@stripe.com"]
  s.homepage = "https://github.com/stripe/subprocess"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A port of Python's subprocess module to Ruby"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
