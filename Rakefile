require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "ninjs"
  gem.homepage = "http://github.com/textnotspeech/ninjs"
  gem.rubyforge_project = "nowarning"
  gem.license = "MIT"
  gem.summary = %Q{ninjs is a command line application to help you write clean, modular javascript applications.}
  gem.description = %Q{Ninjs is a ruby application and small javascript framework that helps you build clean, modular javascript applications. Ninjs encourages "Good Parts" best practices and the Crockford school Module pattern (http://www.crockford.com/). The ninjs command line application is an automatic compiler, written in ruby, and based on the Sprockets library (http://getsprockets.org/).}
  gem.email = "daytonn@gmail.com"
  gem.authors = ["Dayton Nolan"]
  gem.add_runtime_dependency 'rubikon'
  gem.add_runtime_dependency 'fssm'
  gem.add_runtime_dependency 'jsmin'
  gem.add_runtime_dependency 'sprockets'
  gem.add_development_dependency 'rspec', '>= 0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ninjs #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :ndoc do
  desc "Generate documentation with NaturalDocs"
  
  task :generate do
    output = `ndocs -i /Volumes/Storage/Development/ninjs/repository/ninjs/ -o HTML /Volumes/Storage/Development/ninjs/repository/ninjs/docs -p /Volumes/Storage/Development/ninjs/repository/ninjs/docs` #  -s Slick
    puts output
  end
  
end

require 'metric_fu'
