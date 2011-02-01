module Ninjs
  module Command
    def watch
      require "fssm"
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}ninjs.conf"
      color_start = "\e[33m"
      color_end = "\e[0m"
      puts "\e[32m>>>#{color_end} Ninjs are watching for changes. Press Ctrl-C to stop."
      project = Ninjs::Project.init_with_config(project_path)
      project.update
	    
	    # TODO make this smaller using globs
      FSSM.monitor do
        path "#{Ninjs.base_directory}/repository" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} ninjs repository updated #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created in repository"
            project.update
          end
        end
        
        path "#{project_path}elements" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end
        
        path "#{project_path}models" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{@color_start}<<<#{@color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end
        
        path "#{project_path}modules" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.update
          end

          create do |base, relative|
            puts "#{relative} created"
            project.update
          end
        end

        path "#{project_path}lib" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.config.read
            project.update_application_file
            project.update
          end

          create do |base, relative|
            puts "+++ created #{relative}"
            project.update
          end
        end
        
        path "#{project_path}plugins" do
          glob "**/*.js"

          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.config.read
            project.update_application_file
            project.update
          end

          create do |base, relative|
            puts "+++ created #{relative}"
            project.update
          end
        end
        
        path "#{project_path}" do
          glob "**/*.conf"
          
          update do |base, relative|
            puts "#{color_start}<<<#{color_end} change detected in #{relative}"
            project.config.read
            project.update_application_file
            project.update
          end
        end
        
      end
      
    end

    def create(name, directory = false)
      raise 'you must specify a project name: ninjs create ProjectName' if name.nil?
      project = directory ? Ninjs::Project.new(name, directory) : Ninjs::Project.new(name)
      project.create
    end
    
    def compile
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}/ninjs.conf"
      project = Ninjs::Project.init_with_config(project_path)
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
        project = Ninjs::Project.init_with_config(project_path)
        if object === 'module'
          File.open "#{project_path}modules/#{name.downcase}.module.js", "w" do |file|
            file << project.config.name + ".add_module('" + name + "');\n\n"
            file << '//= require "../elements/' + name.downcase + '.elements.js"' + "\n\n" if elements
            file << '//= require "../models/' + name.downcase + '.model.js"' + "\n\n" if models
            file << project.config.name + "." + name + ".actions = function() {\n\n}\n\n"
            file << project.config.name + "." + name + ".run();"
            puts "+++ created #{name.downcase}.module.js"
          end unless File.exists? "#{project_path}modules/#{name.downcase}.module.js"
        elsif object === 'elements'
          File.open("#{project_path}elements/#{name.downcase}" + ".elements.js", "w") do |file|
            file << project.config.name + "." + name + ".elements(function({\n\n}));"
            puts "+++ created #{name.downcase}.elements.js"
          end unless File.exists? "#{project_path}elements/#{name.downcase}.elements.js"
        elsif object === 'model'
          File.open "#{project_path}models/#{name.downcase}.model.js", "w" do |file|
            file << project.config.name + "." + name + ".set_data({});"
            puts "+++ created #{name.downcase}.model.js"
          end unless File.exists? "#{project_path}models/#{name.downcase}.model.js" 
        end
      rescue
        
      end
    end

    module_function :create, :watch, :compile, :help, :import, :generate
  end
end
