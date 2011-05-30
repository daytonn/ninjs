module Ninjs
    class Configuration
      
      attr_reader :root,
                  :path,
                  :settings,
                  :name,
                  :dependencies,
                  :autoload,
                  :asset_root,
                  :src_dir,
                  :dest_dir
                  
      attr_accessor :output
                  
      def initialize(project_path)
        @root =  File.expand_path project_path
        @path = "#{@root}/ninjs.conf"
        @settings = Hash.new
        @asset_root = @root
        
        setting(:name, 'application')
        setting(:src_dir, 'modules')
        setting(:dest_dir, 'application')
        setting(:output, 'expanded')
        setting(:dependencies, ['<jquery/latest>'])
        setting(:autoload, ['../lib/utilities'])
                
        optional_settings.each do |label, setting|
          setting(label, setting)
        end
        
        read if File.exists? "#{@path}"
      end
      
      def optional_settings
        @settings.reject do |key, value|
          key.to_s.match /name|src_dir|dest_dir|output|dependencies|autoload/
        end
      end
      
      def setting(name, value)
        instance_variable_set("@#{name}", value)
        @settings[name] = value
      end

      
      def write
        File.open("#{@path}", "w+") do |conf_file|
          conf_file << "name: #{@name}\n"
          conf_file << "src_dir: #{@src_dir}\n"
          conf_file << "dest_dir: #{@dest_dir}\n"
          conf_file << "output: #{@output}\n"
          conf_file << "dependencies: #{array_to_yml @dependencies}\n"
          conf_file << "autoload: #{array_to_yml @autoload}\n"
          optional_settings.each do |setting, value|
            conf_file << "setting: #{value}\n"
          end
        end
        
        puts Ninjs::Notification.notify "ninjs.conf created", :added
      end
 
      def read
        config = YAML.load_file("#{@project_path}ninjs.conf")
        
        @name = config['name']
        @output = config['output']
        @src_dir = config['src_dir']
        @dest_dir = config['dest_dir']
        
        @dependencies = config['dependencies'] || Array.new
        @autoload = config['autoload'] || Array.new
        
        @asset_root = config['asset_root'] unless config['ass'].nil?
      end
      
      def array_to_yml(array)
        yml = array.empty? ? '[]' : %Q{['#{array.join("', '")}']}
      end
      
    end
end