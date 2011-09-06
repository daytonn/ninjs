module Ninjs
  class Generator
    
    attr_writer :alias, :app_name
    
    def initialize(config)
      @type = config[:type]
      @project = config[:project]
      @name = config[:name]
      @module_name = config[:name].gsub(/^_/, '')
      @alias = config[:alias].nil? ? false : true
      @app_name = config[:alias] || @project.config.name
      @dest = config[:dest] || @project.config.src_dir.is_a?(String) ? @project.config.src_dir : @project.config.src_dir.first
      @dependencies = config[:dependencies] || { elements: false, model: false }
    end
    
    def generate
      generate_module_file if @type === 'module'
      generate_elements_file if @type === 'elements' || @dependencies[:elements]
      generate_model_file if @type === 'model' || @dependencies[:model]
    end
    
    def generate_module_file
      module_content = Array.new
      module_content << "(function(#{@app_name if @alias}) {\n"
      module_content << "\tvar #{@project.config.module_alias} = #{@app_name}.add_module('#{@name}');\n\n"
      module_content << %Q{\t//= require "../elements/#{@name.downcase}.elements"\n} if @dependencies[:elements] || @type === 'elements'
      module_content << %Q{\t//= require "../models/#{@name.downcase}.model"\n\n} if @dependencies[:model] || @type === 'model'
      module_content << "\t#{@project.config.module_alias}.actions = function() {\n\t\t\n\t};\n\n"
      module_content << "\t#{@project.config.module_alias}.run();\n"
      module_content << "\n})(#{@project.config.name if @alias});"
      
      
      File.open "#{@project.root}/#{@dest}/#{@name}.module.js", "w" do |file|
        file << module_content.join('')
        puts Ninjs::Notification.added "created #{@name.downcase}.module.js"
      end unless File.exists? "#{@project.root}/#{@dest}/#{@name}.module.js"
      
      self
    end
    
    def generate_elements_file
      File.open("#{@project.root}/elements/#{@module_name}" + ".elements.js", "w") do |file|
        file << %Q{\t#{@project.config.module_alias}.dom.ready(function() {\n\t\tmod.elements({\n\t\t\t\n\t\t});\n\t});\n}
        puts Ninjs::Notification.added "created #{@module_name}.elements.js"
      end unless File.exists? "#{@project.root}/elements/#{@module_name}.elements.js"
      
      self
    end
    
    def generate_model_file
      File.open "#{@project.root}/models/#{@module_name}.model.js", "w" do |file|
        file << %Q{\t#{@project.config.module_alias}.set_data({\n\t\t\n\t});\n}
        puts Ninjs::Notification.added "created #{@module_name}.model.js"
      end unless File.exists? "#{@project.root}/models/#{@module_name}.model.js"
      
      self
    end
    
  end
end