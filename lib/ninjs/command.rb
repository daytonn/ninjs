module Ninjs
  module Command
    def watch
      require "fssm"
      
      project_path = File.expand_path Dir.getwd
      raise "ninjs.conf was not located in #{project_path}/" unless File.exists? "#{project_path}/ninjs.conf"
      
      puts Ninjs::Notification.log "Ninjs are watching for changes. Press Ctrl-C to stop."
      project = Ninjs::Project.new
      project.update
	    
	    watch_dirs = Ninjs::Manifest.directories.reject { |dir| dir.match(/application|tests/) }
	    watch_hash = Hash.new
	    
	    watch_dirs.each do |dir|
	     watch_hash["#{project_path}/#{dir}"] = "**/*.js"
	    end
	    
	    watch_hash[project_path] = "**/*.conf"
	    watch_hash["#{Ninjs::BASE_DIR}/repository"] = "**/*.js"
	    
	    FSSM.monitor do

	      watch_hash.each do |dir, g|
	        
  	     path "#{dir}" do
           glob g

           update do |base, relative|
             puts Ninjs::Notification.event "change detected in #{relative}"
             project.update
           end

           create do |base, relative|
             puts Ninjs::Notification.event "#{relative} created"
             project.update
           end
         end
         
  	    end

	    end
	           
    end

    def create(name, directory = nil)
      raise 'you must specify a project name: ninjs create ProjectName' if name.nil?
      project = Ninjs::Project.new(name)
      project.root = directory unless directory.nil?
      project.create
    end
    
    def compile(compress_output = 'use_config')
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}/ninjs.conf"
      project = Ninjs::Project.new
      project.config.output = compress_output ? 'compressed' : 'expanded' unless compress_output === 'use_config'
      project.update
    end
    
    def generate(config)
      begin
        conf_path = "#{Dir.getwd}/ninjs.conf"
        raise "ninjs.conf was not located in #{conf_path}" unless File.exists? "#{conf_path}"
        generator = Ninjs::Generator.new(config)
        generator.generate
      end
    end

    def update
      project_path = Dir.getwd << '/'
      raise "ninjs.conf was not located in #{project_path}" unless File.exists? "#{project_path}ninjs.conf"
      
      project = Ninjs::Project.new
      project.create_ninjs_lib_file
      project.create_utility_lib_file
    end
    
    module_function :create,
                    :watch,
                    :compile,
                    :generate,
                    :update
  end
end
