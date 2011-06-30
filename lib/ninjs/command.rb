module Ninjs
  module Command
    def watch(path = nil)
      require "fssm"
      
      path ||= File.expand_path(Dir.getwd)
      raise "ninjs.conf was not located in #{path}" unless File.exists? "#{path}/ninjs.conf"
      
      puts Ninjs::Notification.log "Ninjs are watching for changes. Press Ctrl-C to stop."
      project = Ninjs::Project.new
      project.update
	    
	    watch_dirs = Ninjs::Manifest.directories.reject { |dir| dir.match(/application|tests/) }
	    watch_hash = Hash.new
	    
	    watch_dirs.each do |dir|
	     watch_hash["#{path}/#{dir}"] = "**/*.js"
	    end
	    
	    watch_hash[path] = "**/*.conf"
	    watch_hash["#{Ninjs::BASE_DIR}/repository"] = "**/*.js"
	    
	    FSSM.monitor do

	      watch_hash.each do |dir, g|
	        
  	     path "#{dir}" do
           glob g

           update do |base, relative|
             puts Ninjs::Notification.event "change detected in #{relative}"
             project.config.read if relative.match(/conf$/)
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

    def create(config = nil)
      settings = {
        name: nil,
        root: File.expand_path(Dir.getwd)
      }
      
      settings.merge!(config) unless config.nil?
      
      raise 'you must specify a project name: ninjs create ProjectName' if settings[:name].nil?
      
      project = Ninjs::Project.new({ name: settings[:name], root: settings[:root] })
      project.create
    end
    
    def compile(options = nil)
      settings = {
        force_compress: false,
        path: File.expand_path(Dir.getwd)
      }
      
      settings.merge!(options) unless options.nil?
      
      raise "ninjs.conf was not located in #{settings[:path]}" unless File.exists? "#{settings[:path]}/ninjs.conf"
      project = Ninjs::Project.new(root: settings[:path])
      project.config.output = 'compressed' if settings[:force_compress]
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

    def update(path = nil)
      path = File.expand_path Dir.getwd if path.nil?
      raise "ninjs.conf was not located in #{path}" unless File.exists? "#{path}/ninjs.conf"
      
      project = Ninjs::Project.new({ root: path })
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
