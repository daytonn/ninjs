module Ninjs
  class Project
    attr_reader :root,
                :config,
                :modules
                
    
    def initialize(name = nil)
      if name.nil?
        raise ArgumentError, "Ninjs::Project.new(name): name is required without a configuration file" unless File.exists? 'ninjs.conf'
      end
      
      @root = File.expand_path Dir.getwd
      @modules = Array.new
      @config = Ninjs::Configuration.new @root
      @config.setting :name, name unless name.nil?
    end
    
    def root=(path)
      @root = File.expand_path path
    end
    
    def create
      puts Ninjs::Notification.notice "Creating the #{@config.name} project in #{@root}" 
      @config.write
      create_project_scaffold
      create_ninjs_lib_file
      create_utility_lib_file
      create_ninjs_application_file
      import_test_files
    end
    
    def create_project_scaffold
      Dir.mkdir "#{@root}" unless File.exists? "#{@root}"
      Ninjs::Manifest.directories.each do |folder|
        puts Ninjs::Notification.added "#{folder} created" unless File.exists? "#{@root}/#{folder}"
        Dir.mkdir "#{@root}/#{folder}" unless File.exists? "#{@root}/#{folder}"
      end
    end
    
    def create_ninjs_lib_file
      operation = File.exists?("#{@root}/lib/nin.js") ? 'updated' : 'created'
      ninjs_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs::BASE_DIR}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/core/nin.js"]
      )

      ninjs_lib_secretary.concatenation.save_to "#{@root}/lib/nin.js"

      puts Ninjs::Notification.added "lib/nin.js #{operation}"
    end
    
    def create_utility_lib_file
      utility_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs::BASE_DIR}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/utilities/all.js"]
      )
      
      utility_lib_secretary.concatenation.save_to "#{@root}/lib/utilities.js"
      
      puts Ninjs::Notification.added "lib/utilities.js created"
    end
    
    def create_ninjs_application_file
      filename = "#{@root}/application/#{@config.name.downcase}.js"
      
      File.open(filename, "w+") do |file|
        file << "//-- Ninjs #{Time.now.to_s}  --//\n"
        file << File.open("#{@root}/lib/nin.js", 'r').readlines.join('')
        file << "\nvar #{@config.name} = new NinjsApplication();"
      end
    end
    
    def import_test_files
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/index.html", "#{@root}/tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/ninjs.test.js", "#{@root}/tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/ninjs.utilities.test.js", "#{@root}/tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/qunit/qunit.js", "#{@root}/tests/qunit"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/qunit/qunit.css", "#{@root}/tests/qunit"
    end
    
    def update
      get_updated_modules
      compile_modules
      update_application_file
      compress_application if @config.output == 'compressed'
      puts Ninjs::Notification.log "application updated" unless @errors
      @errors = false
    end
    
    def get_directory_script_files
      script_files = Array.new
      Dir["#{@root}/**/*.js"].each do |file|
        script_files << file unless file.match(/application\/|tests\//)
      end
    end
    
    def get_modules
      @modules = Array.new
      if @config.src_dir.is_a? Array
        @config.src_dir.each do |directory| 
          add_scripts_to_models File.expand_path "#{directory}"
        end 
      else
        add_scripts_to_models File.expand_path "#{@config.src_dir}"
      end
    end
    
    def add_scripts_to_models(directory)
      Dir["#{directory}/*.js"].each do |file|
        module_filename = file.gsub(directory, '')
        @modules << "#{directory}#{module_filename}" unless module_filename.match(/^_/)
      end
    end
    
    def compile_modules
      @modules.each do |module_file|
        module_filename = Ninjs::Helpers.create_module_filename module_file
        compile_module module_file, module_filename
      end
    end
    
    def compile_module(module_file, module_name)
      begin
        ninjs_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Ninjs::BASE_DIR}",
          :asset_root   => @config.asset_root,
          :load_path    => ["repository"],
          :source_files => ["#{module_file}"]
        )

        module_file = ninjs_lib_secretary.concatenation
        message = File.exists?("#{@root}/#{@config.dest_dir}/#{module_name}.js") ? "\e[32m>>>\e[0m #{@config.dest_dir}/#{module_name}.js updated" : "\e[32m>>>\e[0m #{@config.dest_dir}/#{module_name}.js created"
        module_file.save_to "#{@root}/#{@config.dest_dir}/#{module_name}.js"
        ninjs_lib_secretary.install_assets

      rescue Exception => error
        @errors = true
        puts Ninjs::Notification.error "Sprockets error: #{error.message}"
      end
    end
    
    def update_application_file
      application_file = "#{@root}/#{@config.dest_dir}/#{@config.name.downcase}.js"
      
      File.open(application_file, "w+") do |file|
        write_dependencies(file)
        write_core(file)
        write_autoload(file)
      end
      
      compile_application_file application_file
    end
    
    def write_dependencies(file)
      @config.dependencies.each do |dependency|
        file << "/*---------- #{dependency} ----------*/"
        file << "\n//= require #{dependency}\n\n" if dependency.match(/^\<.+\>$/)
        file << "\n//= require \"#{dependency}\"\n\n" if dependency.match(/^[^\<].+|[^\>]$/)
      end
    end
    
    def write_core(file)      
      file << "/*---------- Ninjs core ../lib/nin.js ----------*/\n"
      file << "//= require \"../lib/nin.js\"\n\n"
      file << "\nvar #{@config.name} = new NinjsApplication();\n\n"
    end
    
    def write_autoload(file)
      @config.autoload.each do |auto_file|
        file << "/*---------- Ninjs autoload #{auto_file} ----------*/"
        file << "\n//= require #{auto_file}\n\n" if auto_file.match(/^\<.+\>$/)
        file << "\n//= require \"#{auto_file}\"\n\n" if auto_file.match(/^[^\<].+|[^\>]$/)
      end
    end
    
    def compile_application_file(file)
      begin
        ninjs_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Ninjs::BASE_DIR}",
          :asset_root   => @config.asset_root,
          :load_path    => ["repository"],
          :source_files => ["#{file}"]
        )

        application_file = ninjs_lib_secretary.concatenation
        ninjs_lib_secretary.install_assets
        application_file.save_to "#{file}"
      rescue Exception => error
        @errors = true
        puts Ninjs::Notification.error "Sprockets error: #{error.message}"
      end
    end
    
    def compress_application
      app_root = File.expand_path "#{@config.dest_dir}"
      modules = Dir.entries(app_root)
      modules.reject! { |file| file =~ /^\./ }

      modules.each do |module_file|
        full_path = "#{app_root}/#{module_file}"
        uncompressed = File.open(full_path, "r").readlines.join('')
        File.open(full_path, "w+") do |module_file|
          module_file << JSMin.minify(uncompressed)
        end
      end
    end
  
  end
  # class Project
end
#module Ninjs