module Ninjs
  class Generator
    
    attr_writer :alias, :app_name
    
    def initialize(project, name)
      @project = project
      @name = name
      @alias = false
      @app_name = @use_alias ? 'app' : @project.config.name
    end
    
    def generate_module_file(with = { :elements => false, :model => false })
          
      File.open "#{@project.project_path}modules/#{@name.downcase}.module.js", "w" do |file|
        file << "(function(#{@app_name if @alias}){\n"
        file << "\tvar self = #{@app_name}.add_module('#{@name}');\n\n"
        file << "\t" + '//= require "../elements/' + @name.downcase + '.elements"' + "\n\n" if with[:elements]
        file << "\t" + '//= require "../models/' + @name.downcase + '.model"' + "\n\n" if with[:model]
        file << "\t #{@app_name}.#{@name}.actions = function() {\n\n\t};\n\n"
        file << "\t #{@app_name}.#{@name}.run();\n"
        file << "})(#{@project.config.name if @alias});"
        Ninjs::Notification.added "created #{@name.downcase}.module.js"
      end unless File.exists? "#{@project.project_path}modules/#{@name.downcase}.module.js"
    end
    
    def generate_elements_file
      File.open("#{@project.project_path}elements/#{@name.downcase}" + ".elements.js", "w") do |file|
        file << "#{@app_name}.#{@name}.elements(function() {\n\n});"
        Ninjs::Notification.added "created #{@name.downcase}.elements.js"
      end unless File.exists? "#{@project.project_path}elements/#{@name.downcase}.elements.js"
    end
    
    def generate_model_file
      File.open "#{@project.project_path}models/#{@name.downcase}.model.js", "w" do |file|
        file << "#{@app_name}.#{@name}.set_data({\n\t\n});"
        Ninjs::Notification.added "created #{@name.downcase}.model.js"
      end unless File.exists? "#{@project.project_path}models/#{@name.downcase}.model.js"
    end
    
  end
end