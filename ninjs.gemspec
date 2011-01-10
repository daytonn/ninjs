# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ninjs}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = Time.now.strftime '%Y-%m-%d'
  s.default_executable = %q{bin/ninjs}
  s.description = %q{Ninjs is a javascript meta framework. Ninjs uses the Sprockets engine (http://getsprockets.org/) to allow you to create modular javascript applications.}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["ninjs"]
  s.files = ["bin/ninjs",
             "LICENSE",
             "README.textile"]
  s.homepage = %q{http://textnotspeech.github.com/ninjs/}
  s.add_dependency 'rubikon'
  s.add_dependency 'fssm'
  s.add_dependency 'jsmin'
  s.add_dependency 'sprockets'
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{ninjs is a command line application to help you write clean, modular javascript applications.}
end