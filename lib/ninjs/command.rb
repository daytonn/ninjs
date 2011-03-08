module Ninjs
  module Command
    def watch
      require "fssm"
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}ninjs.conf"
      Ninjs::Notification.log "Ninjs are watching for changes. Press Ctrl-C to stop."
      project = Ninjs::Project.new
      project.update
	    
	    watch_dirs = Ninjs::Manifest.directories.reject { |dir| dir.match(/application|tests/) }
	    watch_hash = Hash.new
	    
	    watch_dirs.each do |dir|
	     watch_hash["#{project_path}#{dir}"] = "**/*.js"
	    end
	    
	    watch_hash[project_path] = "**/*.conf"
	    watch_hash["#{Ninjs.base_directory}/repository"] = "**/*.js"
	    
	    FSSM.monitor do

	      watch_hash.each do |dir, g|
	        
  	     path "#{dir}" do
           glob g

           update do |base, relative|
             Ninjs::Notification.event "change detected in #{relative}"
             project.update
           end

           create do |base, relative|
             Ninjs::Notification.event "#{relative} created"
             project.update
           end
         end
         
  	    end

	    end
	           
    end

    def create(name, directory = false)
      raise 'you must specify a project name: ninjs create ProjectName' if name.nil?
      project = directory ? Ninjs::Project.new(directory, name) : Ninjs::Project.new('/', name)
      project.create
    end
    
    def compile
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}/ninjs.conf"
      project = Ninjs::Project.new
      project.update
    end
    
    def import(package)
      Ninjs::PackageManager.import(package)
    end

    def help
      puts <<-DOC
      
Description: 
The ninjs command line tool will compile your ninjs application into modules.
To compile your ninjs application into module files:

Usage: ninjs [action] [options]
  
Actions:
  compile  Compiles the ninjs project in the current working directory
  watch    Watches the current working directory for 
           file changes and compiles when files change
  create   Generates ninjs application architecture and files  
           Options:
             -p, --directory  Optional install directory for a new ninjs project
                              (creates the folder if it does not exist)
  
Example:
  ninjs create MyApplication
  ninjs watch
      DOC
    end
    
    def generate(object, name, create_elements = false, create_models = false, elements = false, models = false)
      begin
        project_path = Dir.getwd << '/'
        raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}ninjs.conf"
        project = Ninjs::Project.new
        if object === 'module'
          File.open "#{project_path}modules/#{name.downcase}.module.js", "w" do |file|
            file << project.config.name + ".add_module('" + name + "');\n\n"
            file << '//= require "../elements/' + name.downcase + '.elements.js"' + "\n\n" if elements
            file << '//= require "../models/' + name.downcase + '.model.js"' + "\n\n" if models
            file << project.config.name + "." + name + ".actions = function() {\n\n}\n\n"
            file << project.config.name + "." + name + ".run();"
            Ninjs::Notification.added "created #{name.downcase}.module.js"
          end unless File.exists? "#{project_path}modules/#{name.downcase}.module.js"
        elsif object === 'elements'
          File.open("#{project_path}elements/#{name.downcase}" + ".elements.js", "w") do |file|
            file << project.config.name + "." + name + ".elements(function({\n\n}));"
            Ninjs::Notification.added "created #{name.downcase}.elements.js"
          end unless File.exists? "#{project_path}elements/#{name.downcase}.elements.js"
        elsif object === 'model'
          File.open "#{project_path}models/#{name.downcase}.model.js", "w" do |file|
            file << project.config.name + "." + name + ".set_data({});"
            Ninjs::Notification.added "created #{name.downcase}.model.js"
          end unless File.exists? "#{project_path}models/#{name.downcase}.model.js" 
        end
      rescue
        # TODO rescue this
      end
    end

    module_function :create, :watch, :compile, :help, :import, :generate
  end
end
