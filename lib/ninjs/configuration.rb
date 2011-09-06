module Ninjs
    class Configuration

      attr_accessor :root,
                    :name,
                    :src_dir,
                    :dest_dir,
                    :asset_root,
                    :asset_root_relative,
                    :output,
                    :dependencies,
                    :autoload,
                    :module_alias

      def initialize(project_path)
        @root =  File.expand_path project_path
        @name = 'application'
        @src_dir = 'modules'
        @dest_dir = 'application'
        @asset_root_relative = '../'
        @asset_root = File.expand_path('../', @root)
        @output = 'expanded'
        @dependencies = ['<jquery/latest>']
        @autoload = ['../lib/utilities']
        @module_alias = 'mod'

        read if File.exists? "#{@root}/ninjs.conf"
      end

      def write
        File.open("#{@root}/ninjs.conf", "w+") do |conf_file|
          conf_file << "name: #{@name}\n"
          conf_file << "src_dir: #{@src_dir}\n"
          conf_file << "dest_dir: #{@dest_dir}\n"
          conf_file << "asset_root: #{@asset_root_relative} # relative to project root\n"
          conf_file << "output: #{@output}\n"
          conf_file << "dependencies: #{array_to_yml @dependencies}\n"
          conf_file << "autoload: #{array_to_yml @autoload}\n"
          conf_file << "module_alias: #{@module_alias}\n"
        end

        puts Ninjs::Notification.notify "ninjs.conf created", :added
      end

      def read
        config = YAML.load_file("#{@root}/ninjs.conf")

        @name = config['name']
        @src_dir = config['src_dir']
        @dest_dir = config['dest_dir']
        @asset_root_relative = config['asset_root'] || @asset_root_relative
        @asset_root = File.expand_path(@asset_root_relative, @root)
        @output = config['output']
        @dependencies = config['dependencies'] || Array.new
        @autoload = config['autoload'] || Array.new
        @module_alias = config['module_alias'] || 'mod'
      end

      def array_to_yml(array)
        yml = array.empty? ? '[]' : %Q{['#{array.join("', '")}']}
      end

    end
end