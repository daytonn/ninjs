module Ninjs
    class Configuration
      
      attr_reader :name,
                  :app_filename,
                  :directory,
                  :output,
                  :dependencies,
                  :autoload,
                  :config_path,
                  :asset_root,
                  :base_url,
                  :test_path
                  
      def initialize(project_path, name = '')
        @project_path = project_path
        @defaults = {
          :name => name,
          :app_filename => name.gsub(/\s|\-|\./, '').downcase,
          :output => 'expanded',
          :dependencies => ['<jquery/latest>'],
          :autoload => ['<ninjs/utilities/all>'],
          :base_url => 'http://www.example.com/',
          :test_path => 'tests/'
        }

        @defaults.each do |label, setting|
          instance_variable_set("@#{label}", setting)
        end
        
        if File.exists? "#{@project_path}ninjs.conf"
          read
        end
      end
      
      def create
        options = @defaults
        options.delete :app_filename
        default_content = conf_content options
        create_conf_file default_content
      end
      
      def conf_content(options)
        content = String.new
        options.each do |option, value|
          content << "#{option}: #{value}\n"
        end
        content
      end
      
      def create_conf_file(content)
        File.open("#{@project_path}ninjs.conf", "w+") do |conf_file|
          conf_file << conf_content(@defaults)
        end
        
        Ninjs::Notification.notice "ninjs.conf created"
      end
      
      def update
        options = {
          :name => @name,
          :asset_root => @asset_root,
          :output => @output,
          :dependencies => @dependencies,
          :autoload => @autoload,
          :base_url => @base_url,
          :test_path => @test_path
        }
        options.reject! { |option| option.nil? }
        
        content = conf_content options
        create_conf_file content
      end
      
      def read
        config = YAML.load_file("#{@project_path}ninjs.conf")
        @asset_root = config['asset_root'] unless config['asset_root'].nil?
        @name = config['name']
        @app_filename = config['name'].downcase
        @output = config['output']
        @dependencies = config['dependencies'] || Array.new
        @autoload = config['autoload'] || Array.new
        @base_url = config['base_url'] || 'http://www.example.com/'
        @test_path = config['test_path'] || 'tests/'
      end
      
    end
end