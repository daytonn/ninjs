module Ninjs
  class Project
    
    def self.init_with_config(project_path)
      config = Ninjs::Configuration.new project_path
      config.read
      
      project = Project.new
      project.config = config
      project.project_path = config.project_path
      project.app_filename = config.name.downcase
      project
    end
    
    attr_reader :app_filename,
                :project_path,
                :config
    attr_writer :config,
                :project_path,
                :app_filename
    
    def initialize(name = 'JudoApplication', project_dir = '/')
       name.gsub!(/\s|\-|\./)
       proj_dir = clean_project_path project_dir
       @modules = Array.new
       
       @color_start = "\e[32m"
       @color_end = "\e[0m"
       
       @app_filename = name.downcase
       @project_path = "#{Ninjs.root_directory}#{proj_dir}"
       @config = Ninjs::Configuration.new @project_path, name
    end
    
    def clean_project_path(dir)
      dir += '/' unless dir.match(/\/$/)
      dir = '/' << dir unless dir.match(/^\//)
      dir
    end
    
    def create
      puts "#{@color_start}>>>#{@color_end} Creating the #{@config.name} project in #{@project_path}" 
      create_project_structure
      @config.create
      create_ninjs_lib_file
      create_utility_lib_file
      create_ninjs_application_file
      import_test_files
    end
    
    def create_project_structure
      Dir.mkdir "#{@project_path}" unless File.is_defined? "#{@project_path}"
      
      Ninjs::Manifest.directories.each do |folder|
        puts "#{folder}/ created" unless File.is_defined? "#{@project_path}/#{folder}"
        Dir.mkdir "#{@project_path}#{folder}" unless File.is_defined? "#{@project_path}#{folder}"
      end
    end
    
    def create_ninjs_lib_file
      ninjs_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs.base_directory}",
        :asset_root   => "#{@config.asset_root}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/core/ninjs.js"]
      )

      ninjs_lib_secretary.concatenation.save_to "#{@project_path}lib/ninjs.js"

      puts "lib/ninjs.js created"
    end
    
    def create_utility_lib_file
      utility_lib_secretary = Sprockets::Secretary.new(
        :root         => "#{Ninjs.base_directory}",
        :asset_root   => "#{@config.asset_root}",
        :load_path    => ["repository"],
        :source_files => ["repository/ninjs/utilities/all.js"]
      )
      
      utility_lib_secretary.concatenation.save_to "#{@project_path}lib/utilities.js"
      
      puts "lib/utilities.js created"
    end
    
    def create_ninjs_application_file      
      filename = "#{@project_path}application/#{@app_filename}.js"
      
      File.open(filename, "w+") do |file|
        file << "//-- Ninjs #{Time.now.to_s}  --//\n"
        file << File.open("#{@project_path}lib/nin.js", 'r').readlines.join('')
        file << "\nvar #{@config.name} = new JudoApplication();"
      end
    end
    
    def import_test_files
      File.copy "#{Ninjs.base_directory}/repository/ninjs/tests/index.html", "#{@project_path}tests"
      File.copy "#{Ninjs.base_directory}/repository/ninjs/tests/ninjs.test.js", "#{@project_path}tests"
      File.copy "#{Ninjs.base_directory}/repository/ninjs/tests/ninjs.utilities.test.js", "#{@project_path}tests"
    end
    
    def update
      #read_cache
      get_updated_modules
      compile_modules
      update_application_file
      compress_application if @config.output == 'compressed'
      puts "#{@color_start}>>>#{@color_end} application updated" unless @errors
      @errors = false
      #write_cache
    end
    
    def read_cache
      if File.is_defined? "#{@project_path}.cache"
          parse_cache File.open("#{@project_path}.cache").readlines
      else
        create_cache
        read_cache
      end
    end
    
    def parse_cache(cache_lines)
      @cache_files = Hash.new
      cache_lines.each do |line|
        cache_file = line.split('|')
        @cache_files[cache_file.first] = cache_file.last
      end
    end
    
    def create_cache      
      File.open("#{@project_path}.cache", 'w+')
    end
    
    def write_cache
      directory_files = get_directory_script_files
      timestamped_files = get_files_timestamps directory_files
      File.open("#{@project_path}.cache", 'w+') do |cache_file|
        timestamped_files.each do |file, mtime|
          cache_file << file + '|' + mtime + "\n"
        end
      end
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
      # TODO actually check the files against the cache
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
            :root         => "#{Ninjs.base_directory}",
            :asset_root   => "#{@config.asset_root}",
            :load_path    => ["repository"],
            :source_files => ["#{module_src}"]
          )

          module_file = ninjs_lib_secretary.concatenation
          message = File.is_defined?("#{@project_path}application/#{module_name}.js") ? "\e[32m>>>\e[0m application/#{module_name}.js updated" : "\e[32m>>>\e[0m application/#{module_name}.js created"
          module_file.save_to "#{@project_path}application/#{module_name}.js"
          ninjs_lib_secretary.install_assets

          #puts message
        rescue Exception => error
          @errors = true
          puts "Sprockets error: #{error.message}"
        end
        
    end
    
    def update_application_file
      message = File.is_defined?("#{@project_path}application/#{@app_filename}.js") ? "application/#{@app_filename}.js updated" : "application/#{@app_filename}.js created"            
      filename = "#{@project_path}application/#{@app_filename}.js"
      
      File.open(filename, "w+") do |file|
        @config.dependencies.each do |dependency|
          file << "/*---------- #{dependency} ----------*/"
          file << "\n//= require #{dependency}\n\n" if dependency.match(/^\<.+\>$/)
          file << "\n//= require \"#{dependency}\"\n\n" if dependency.match(/^[^\<].+|[^\>]$/)
        end
        
        file << "/* Ninjs #{Time.now.to_s} */\n"
        file << "//= require \"../lib/nin.js\"\n\n"
        file << "\nvar #{@config.name} = new JudoApplication();\n\n"
        
        @config.autoload.each do |auto_file|
            file << "/*---------- Ninjs autoload #{auto_file} ----------*/"
            file << "\n//= require #{auto_file}\n\n" if auto_file.match(/^\<.+\>$/)
            file << "\n//= require \"#{auto_file}\"\n\n" if auto_file.match(/^[^\<].+|[^\>]$/)
        end
      end
      
      begin
        ninjs_lib_secretary = Sprockets::Secretary.new(
          :root         => "#{Ninjs.base_directory}",
          :asset_root   => "#{@config.asset_root}",
          :load_path    => ["repository"],
          :source_files => ["#{filename}"]
        )

        application_file = ninjs_lib_secretary.concatenation
        ninjs_lib_secretary.install_assets
        application_file.save_to "#{filename}"
      rescue Exception => error
        @errors = true
        puts "\e[0;31m!!!\e[0m Sprockets error: #{error.message}"
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
end