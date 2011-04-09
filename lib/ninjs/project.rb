module Ninjs
  class Project    
    attr_reader :app_filename,
                :project_path,
                :config
    attr_writer :config,
                :project_path,
                :app_filename
    
    def initialize(sub_dir = '/', name = '')
      path = add_slashes sub_dir
      @project_path = Dir.getwd + path
      @modules = Array.new
      @config = Ninjs::Configuration.new @project_path, name
    end
    
    def add_slashes(dir)
      dir += '/' unless dir.match(/\/$/)
      dir = '/' << dir unless dir.match(/^\//)
      dir
    end
    
    def create
      Ninjs::Notification.notice "Creating the #{@config.name} project in #{@project_path}" 
      create_project_structure
      Ninjs::Notification.notice "created the project structure"
      @config.create
      create_ninjs_lib_file
      create_utility_lib_file
      create_ninjs_application_file
      import_test_files
    end
    
    def create_project_structure
      Dir.mkdir "#{@project_path}" unless File.exists? "#{@project_path}"
      Ninjs::Manifest.directories.each do |folder|
        Ninjs::Notification.added "#{folder}/ created" unless File.exists? "#{@project_path}#{folder}"
        Dir.mkdir "#{@project_path}#{folder}" unless File.exists? "#{@project_path}#{folder}"
      end
    end
    
    def create_ninjs_lib_file
      operation = File.exists?("#{@project_path}lib/nin.js") ? 'updated' : 'created'
      ninjs_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs::BASE_DIR}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/core/nin.js"]
      )

      ninjs_lib_secretary.concatenation.save_to "#{@project_path}lib/nin.js"

      Ninjs::Notification.added "lib/nin.js #{operation}"
    end
    
    def create_utility_lib_file
      utility_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs::BASE_DIR}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/utilities/all.js"]
      )
      
      utility_lib_secretary.concatenation.save_to "#{@project_path}lib/utilities.js"
      
      Ninjs::Notification.added "lib/utilities.js created"
    end
    
    def create_ninjs_application_file
      filename = "#{@project_path}application/#{@config.app_filename}.js"
      
      File.open(filename, "w+") do |file|
        file << "//-- Ninjs #{Time.now.to_s}  --//\n"
        file << File.open("#{@project_path}lib/nin.js", 'r').readlines.join('')
        file << "\nvar #{@config.name} = new NinjsApplication('#{@config.base_url}', '#{@config.test_path}');"
      end
    end
    
    def import_test_files
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/index.html", "#{@project_path}tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/ninjs.test.js", "#{@project_path}tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/ninjs.utilities.test.js", "#{@project_path}tests"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/qunit/qunit.js", "#{@project_path}tests/qunit"
      FileUtils.cp "#{Ninjs::BASE_DIR}/repository/ninjs/tests/qunit/qunit.css", "#{@project_path}tests/qunit"
    end
    
    def update
      get_updated_modules
      compile_modules
      update_application_file
      compress_application if @config.output == 'compressed'
      Ninjs::Notification.log "application updated" unless @errors
      @errors = false
    end
    
    def get_directory_script_files
      script_files = Array.new
      Dir["#{@project_path}**/*.js"].each do |file|
        script_files << file unless file.match(/application\/|tests\//)
      end
    end
    
    def get_files_timestamps(files)
      timestamped_files = Hash.new
      files.each do |file|
        timestamped_files["#{file}"] = File.new(file).mtime.to_s
      end
      timestamped_files
    end
    
    def get_updated_modules
      # TODO actually check the files against a cache
      @modules = Array.new
      Dir["#{@project_path}modules/*.js"].each do |file|
        module_filename = file.gsub(@project_path + 'modules/', '')
        @modules << module_filename unless module_filename.match(/^_/)
      end
    end
    
    def compile_modules
      @modules.each do |module_file|
        module_filename = Ninjs::Helpers.create_module_filename module_file
        create_module_file module_file, module_filename
      end
    end
    
    def create_module_file(module_file, module_name)
      begin
        module_src = "#{@project_path}modules/#{module_file}"

        ninjs_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Ninjs::BASE_DIR}",
          :asset_root   => @config.asset_root || @project_path.gsub(/[a-zA-z0-9\.\-\_\s]+\/$/, ''),
          :load_path    => ["repository"],
          :source_files => ["#{module_src}"]
        )

        module_file = ninjs_lib_secretary.concatenation
        message = File.exists?("#{@project_path}application/#{module_name}.js") ? "\e[32m>>>\e[0m application/#{module_name}.js updated" : "\e[32m>>>\e[0m application/#{module_name}.js created"
        module_file.save_to "#{@project_path}application/#{module_name}.js"
        ninjs_lib_secretary.install_assets

      rescue Exception => error
        @errors = true
        Ninjs::Notification.error "Sprockets error: #{error.message}"
      end
    end
    
    def update_application_file
      application_file = "#{@project_path}application/#{@config.app_filename}.js"
      
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
      file << "\nvar #{@config.name} = new NinjsApplication('#{@config.base_url}', '#{@config.test_path}');\n\n"
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
          :asset_root   => @config.asset_root || @project_path.gsub(/[a-zA-z0-9\.\-\_\s]+\/$/, ''),
          :load_path    => ["repository"],
          :source_files => ["#{file}"]
        )

        application_file = ninjs_lib_secretary.concatenation
        ninjs_lib_secretary.install_assets
        application_file.save_to "#{file}"
      rescue Exception => error
        @errors = true
        Ninjs::Notification.error "Sprockets error: #{error.message}"
      end
    end
    
    def compress_application
      application = @project_path + 'application'
      modules = Dir.entries(application)
      modules.reject! { |file| file =~ /^\./ }

      modules.each do |module_file|
        full_path = application + "/#{module_file}"
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