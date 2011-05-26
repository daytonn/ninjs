module Ninjs
  class Generator
    
    attr_reader :project
    attr_writer :alias, :app_name
    
    def initialize(config)
      @type = config[:type]
      @project = config[:project] || Ninjs::Project.new
      @name = config[:name]
      @module_name = config[:name].gsub(/^_/, '')
      @alias = config[:alias].nil? ? false : true
      @app_name = config[:alias] || @project.config.name
      @dest = config[:dest] || @project.config.src_dir.is_a?(String) ? @project.config.src_dir : @project.config.src_dir.first
      @dependencies = config[:dependencies] || { :elements => false, :model => false }
    end
    
    def generate
      generate_module_file if @type === 'module'
      generate_elements_file if @type === 'elements' || @dependencies[:elements]
      generate_model_file if @type === 'model' || @dependencies[:model]
    end
    
    def generate_module_file
      File.open "#{@project.path}#{@dest}/#{@name}.module.js", "w" do |file|
        file << "(function(#{@app_name if @alias}) {\n"
        file << "\tvar self = #{@app_name}.add_module('#{@name}');\n\n"
        file << %Q(\t//= require "../elements/#{@name.downcase}.elements"\n\n) if @dependencies[:elements] || @type === 'elements'
        file << %Q(\t//= require "../models/#{@name.downcase}.model\n\n) if @dependencies[:model] || @type === 'model'
        file << "\t#{@app_name}.#{@module_name}.actions = function() {\n\n\t};\n\n"
        file << "\t#{@app_name}.#{@module_name}.run();\n"
        file << "})(#{@project.config.name if @alias});"
        puts Ninjs::Notification.added "created #{@name.downcase}.module.js"
      end unless File.exists? "#{@project.path}#{@dest}/#{@name}.module.js"
      
      self
    end
    
    def generate_elements_file
      File.open("#{@project.path}elements/#{@module_name}" + ".elements.js", "w") do |file|
        file << "#{@app_name}.#{@module_name}.elements({\n\n});"
        puts Ninjs::Notification.added "created #{@module_name}.elements.js"
      end unless File.exists? "#{@project.path}elements/#{@module_name}.elements.js"
      
      self
    end
    
    def generate_model_file
      File.open "#{@project.path}models/#{@module_name}.model.js", "w" do |file|
        file << "#{@app_name}.#{@module_name}.set_data({\n\t\n});"
        puts Ninjs::Notification.added "created #{@module_name}.model.js"
      end unless File.exists? "#{@project.path}models/#{@module_name}.model.js"
      
      self
    end
    
  end
end