module Ninjs
  class Generator
    
    def initialize(project, name, use_alias)
      @project = project
      @name = name
      @app_name = use_alias ? 'app' : @project.config.name
    end
    
    def generate_module_file(with = { :elements => false, :model => false }, use_alias = false)      
      File.open "#{@project.project_path}modules/#{@name.downcase}.module.js", "w" do |file|
        file << "(function(){\n"
        file << "\tvar self = #{@app_name}.add_module('#{@name}');\n\n"
        file << "\t" + '//= require "../elements/' + @name.downcase + '.elements.js"' + "\n\n" if with[:elements]
        file << "\t" + '//= require "../models/' + @name.downcase + '.model.js"' + "\n\n" if with[:model]
        file << "\t #{@app_name}.#{@name}.actions = function() {\n\n\t};\n\n"
        file << "\t #{@app_name}.#{@name}.run();\n"
        file << "})();"
        Ninjs::Notification.added "created #{@name.downcase}.module.js"
      end unless File.exists? "#{@project.project_path}modules/#{@name.downcase}.module.js"
    end
    
    def generate_elements_file
      File.open("#{@project.project_path}elements/#{@name.downcase}" + ".elements.js", "w") do |file|
        file << "#{@app_name}.#{@name}.elements(function({\n\n}));"
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