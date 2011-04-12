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
	    watch_hash["#{Ninjs::BASE_DIR}/repository"] = "**/*.js"
	    
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
ninjs #{Ninjs::VERSION}
Copyright (c) #{Time.new.year} Dayton Nolan
Released under the MIT License

Description: 
The ninjs command line application is a simple way to quickly develop and manage your application. With it you can create an application, generate scaffolding, compile, and upgrade your application.

Usage: ninjs [command] [arguments]
  
Commands:
  create    Creates a new ninjs application in the current working 
            directory or sub directory within.
          
            Arguments:
            application name - Name of the ninjs application
            sub directory* - Directory where the application will be 
                            installed (created if non existent)
                                      
            examples:
            ninjs create myapp
            ninjs create myapp subdirectory

  generate  Generates scoffolding for the given component file type. 

            Arguments:
            file type - Type of application file to create (module, elements,
                        model).
            module name* - Name of the module to generate the scaffold for

            Flags:
            -e - Generate an elements file for the same module
            -m - Generate a model file for the same module

            examples:
            ninjs generate model mymodule -e -m
            ninjs generate elements mymodule
            ninjs generate model mymodule
            
  compile   Compiles the ninjs project in the current working directory.
            
            example:
            ninjs compile
            
  watch     Watches the current working directory for file changes and
            compiles when changes are detected.
            
            example:
            ninjs watch
            
  upgrade   Upgrades your application's core files to the latest version.

  * optional argument
      DOC
    end
    
    def generate(object, name, with, use_alias = false)
      begin
        conf_path = "#{Dir.getwd}/ninjs.conf"
        raise "ninjs.conf was not located in #{conf_path}" unless File.exists? "#{conf_path}"
        generator = Ninjs::Generator.new(Ninjs::Project.new, name, use_alias)
        
        case object
          when 'module'       
            generator.generate_module_file(with)
            generator.generate_elements_file if with[:elements]
            generator.generate_model_file if with[:model]
          when 'elements'
            generator.generate_elements_file
          when 'model'
            generator.generate_model_file
          end
      end
    end

    def upgrade
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}ninjs.conf"
      project = Ninjs::Project.new
      
      project.create_ninjs_lib_file
    end
    
    module_function :create, :watch, :compile, :help, :import, :generate, :upgrade
  end
end
