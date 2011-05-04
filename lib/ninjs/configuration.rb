module Ninjs
    class Configuration
      
      attr_reader :name,
                  :dependencies,
                  :autoload,
                  :asset_root
                  
      attr_accessor :output
                  
      def initialize(project_path, name = '')
        @project_path = project_path
        
        @defaults = {
          :name => name,
          :output => 'expanded',
          :dependencies => ['"<jquery/latest>"'],
          :autoload => ['"../lib/utilities"']
        }
        
        @asset_root = @project_path

        @defaults.each do |label, setting|
          instance_variable_set("@#{label}", setting)
        end
        
        if File.exists? "#{@project_path}ninjs.conf"
          read
        end
      end
      
      def create
        create_conf_file conf_content(@defaults)
      end
      
      def conf_content(options)
        content = String.new
        options.each do |option, value|
          content << "#{option}: #{value}\n" if value.kind_of? String
          content << "#{option}: [#{value.join(', ')}]\n" if value.kind_of? Array
        end
        content
      end
      
      def create_conf_file(content)
        File.open("#{@project_path}ninjs.conf", "w+") do |conf_file|
          conf_file << conf_content(@defaults)
        end
        
        Ninjs::Notification.notify "ninjs.conf created", :added
      end
 
      def read
        config = YAML.load_file("#{@project_path}ninjs.conf")
        
        @name = config['name']
        @output = config['output']
        
        @dependencies = config['dependencies'] || Array.new
        @autoload = config['autoload'] || Array.new
        
        @asset_root = config['asset_root'] unless config['ass'].nil?
      end
      
    end
end