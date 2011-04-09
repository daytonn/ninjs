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
--dev
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
    
    def generate(object, name, with)
      begin
        conf_path = "#{Dir.getwd}/ninjs.conf"
        raise "ninjs.conf was not located in #{conf_path}" unless File.exists? "#{conf_path}"
        generator = Ninjs::Generator.new(Ninjs::Project.new, name)
        
        case object
        when 'module'       
          generator.generate_module_file(with)
          generator.generate_elements_file if with[:elements]
          generator.generate_model_file if with[:model]
        when 'elements'
          generator.generate_elements_file
        when 'model'
          generator.generate_model_file
        end #case
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
