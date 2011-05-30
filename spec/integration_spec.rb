=begin
require "spec_helper"

describe Ninjs do
  context 'When instantiating a new project' do
    before :each do
      @spec_dir = File.expand_path(Dir.getwd) + '/'
      @project_path = spec_dir('js/')
      @new_project = Ninjs::Project.new 'MyApplication', 'spec/js'
    end

    it 'should have the correct app_filename' do
      @new_project.config.app_filename.should === 'myapplication'
    end

    it 'should have the correct project_path' do
      @new_project.root.should === @project_path
    end

    it 'should have a @config property' do
      @new_project.config.should_not be_nil
    end

    it 'should have the correct @config.name' do
      @new_project.config.name.should === 'MyApplication'
    end

    it 'should have the correct @config.output' do
      @new_project.config.output.should === 'expanded'
    end

    it 'should have the correct @config.dependencies' do
      @new_project.config.dependencies.should == ["<jquery/latest>"]
    end

    it 'should have the correct @config.autoload' do
      @new_project.config.autoload.should == ["<ninjs/utilities/all>"]
    end

    it 'should have the corect @config.base_url' do
      @new_project.config.base_url.should == 'http://www.example.com/'
    end

    it 'should have the correct @config.test_path' do
      @new_project.config.test_path.should == 'tests/'
    end
    
    it 'should respond to create' do
      @new_project.should respond_to :create
    end
    
    it 'should create the project directory' do
      @new_project.create
      File.exists?('/Volumes/Storage/Development/ninjs/spec/js').should be_true
    end
  
    it 'should have created the Ninjs::Manifest directories' do
      Ninjs::Manifest.directories.each do |folder|
        File.exists?("#{@project_path}#{folder}").should be_true
      end
    end
    
    it 'should have created a config file' do
      File.exists?("#{@project_path}ninjs.conf").should be_true
    end
    
    it 'should have created the application file' do
      File.exists?("#{@project_path}application/myapplication.js").should be_true
    end
    
    it 'should have created the /lib/nin.js file' do
      File.exists?("#{@project_path}lib/nin.js")
    end
    
    it 'should have created the /lib/utilities.js file' do
      File.exists?("#{@project_path}lib/utilities.js").should be_true
    end
    
    it 'should have created the /tests/index.html file' do
      File.exists?("#{@project_path}tests/index.html").should be_true
    end
    
    it 'should have created the /tests/ninjs.test.js file' do
      File.exists?("#{@project_path}tests/ninjs.test.js").should be_true
    end
    
    it 'should have created the /tests/ninjs.utilties.test.js file' do
      File.exists?("#{@project_path}tests/ninjs.utilities.test.js").should be_true
    end
    
    it 'should have the correct config file content' do
      expected_conf_file = File.open('/Volumes/Storage/Development/ninjs/spec/fixtures/ninjs.conf', 'r')
      expected_conf_content = expected_conf_file.readlines
      expected_conf_file.close
      
      ninjs_conf_file = File.open("#{@project_path}ninjs.conf", 'r')
      ninjs_conf_content = ninjs_conf_file.readlines
      ninjs_conf_file.close
      
      ninjs_conf_content.should === expected_conf_content
    end
    
    it 'should have the correct application file content' do
      expected_file = File.open('/Volumes/Storage/Development/ninjs/spec/fixtures/myapplication.js', 'r')
      expected_content = expected_file.readlines
      
      # .shift is to remove the generated comment which should never match
      expected_content.shift
      expected_file.close
      
      actual_file = File.open("#{@project_path}application/myapplication.js", 'r')
      actual_content = actual_file.readlines
      actual_content.shift
      actual_file.close
      
      actual_content.should === expected_content
    end
    
    it 'should have the correct /lib/nin.js content' do
      expected_ninjs_lib_file = File.open('/Volumes/Storage/Development/ninjs/spec/fixtures/nin.js', "r")
      expected_ninjs_lib_content= expected_ninjs_lib_file.readlines
      expected_ninjs_lib_file.close
      
      ninjs_lib_file = File.open("#{@project_path}lib/nin.js", "r")
      ninjs_lib_content = ninjs_lib_file.readlines
      ninjs_lib_file.close
      
      ninjs_lib_content.should === expected_ninjs_lib_content      
    end
    
    it 'should have the correct /lib/utilities.js' do
      expected_utility_lib_file = File.open("/Volumes/Storage/Development/ninjs/spec/fixtures/utilities.js", "r")
      expected_utility_lib_content = expected_utility_lib_file.readlines
      expected_utility_lib_file.close
      
      utility_lib_file = File.open("#{@project_path}lib/utilities.js", "r")
      utility_lib_content = utility_lib_file.readlines
      utility_lib_file.close
      
      utility_lib_content.should === expected_utility_lib_content
    end
    
    context 'and a project is updated' do
      
      before :each do
        @path = Dir.getwd
        @project = Ninjs::Project.new 'MyApplication', 'spec/js/'
        
        FileUtils.cp("#{@path}/spec/fixtures/global.module.js", "#{@path}/spec/js/modules") unless File.exists?("#{@path}/spec/js/modules/global.module.js")
        FileUtils.cp("#{@path}/spec/fixtures/test.module.js", "#{@path}/spec/js/modules") unless File.exists?("#{@path}/spec/js/modules/test.module.js")
        FileUtils.cp("#{@path}/spec/fixtures/test.elements.js", "#{@path}/spec/js/elements") unless File.exists?("#{@path}/spec/js/elements/test.elements.js")
        FileUtils.cp("#{@path}/spec/fixtures/test.model.js", "#{@path}/spec/js/models") unless File.exists?("#{@path}/spec/js/models/test.model.js")
        @project.update
      end
      
      it 'should have created the /application/global.js module' do
        File.exists?("#{@path}/spec/js/application/global.js").should be_true
      end
      
      it 'should have created the /application/test.js module' do
        File.exists?("#{@path}/spec/js/application/test.js").should be_true
      end
      
      it 'should have the correct /application/global.js content' do
        expected_global_file = File.open("#{@path}/spec/fixtures/global.js", "r")
        expected_global_content = expected_global_file.readlines
        expected_global_file.close
        
        actual_global_file = File.open("#{@path}/spec/js/application/global.js", "r")
        actual_global_content = actual_global_file.readlines
        actual_global_file.close
        
        actual_global_content.should == expected_global_content
      end
      
      it 'should have the correct /application/test.js content' do
        expected_test_file = File.open("#{@path}/spec/fixtures/test.js", "r")
        expected_test_content = expected_test_file.readlines
        expected_test_file.close
        
        actual_test_file = File.open("#{@path}/spec/js/application/test.js", "r")
        actual_test_content = actual_test_file.readlines
        actual_test_file.close
        
        actual_test_content.should == expected_test_content
      end
    end
    
  end# context When instantiating a new project
  
  context 'When instantiating a project from a config file' do
    before :each do
      @spec_dir = spec_dir + '/'
      @project_path = @spec_dir + 'js/'
      @existing_project = Ninjs::Project.new 'MyApplication', 'spec/js'
    end
    
    it 'should have the correct app_filename' do
      @existing_project.config.app_filename.should === 'myapplication'
    end
    
    it 'should have the correct project_path' do
      @existing_project.root.should === @project_path
    end
    
    it 'should have the correct @config.name' do
      @existing_project.config.name.should === 'MyApplication'
    end
    
    it 'should have the correct @config.output' do
      @existing_project.config.output === 'expanded'
    end
    
    it 'should have the correct @config.dependencies' do
      @existing_project.config.dependencies.should == ["<jquery/latest>"]
    end

    it 'should have the correct @config.autoload' do
      @existing_project.config.autoload.should == ["<ninjs/utilities/all>"]
    end

    it 'should have the corect @config.base_url' do
      @existing_project.config.base_url == 'http://www.example.com/'
    end

    it 'should have the correct @config.test_path' do
      @existing_project.config.test_path == 'tests/'
    end
    
    it 'should not need a hack to delete all the files' do
      File.delete("#{@project_path}ninjs.conf") if File.exists?("#{@project_path}ninjs.conf")
      File.delete("#{@project_path}application/myapplication.js") if File.exists?("#{@project_path}application/myapplication.js")
      File.delete("#{@project_path}application/global.js") if File.exists?("#{@project_path}application/global.js")
      File.delete("#{@project_path}application/test.js") if File.exists?("#{@project_path}application/test.js")
      File.delete("#{@project_path}elements/test.elements.js") if File.exists?("#{@project_path}elements/test.elements.js")
      File.delete("#{@project_path}models/test.model.js") if File.exists?("#{@project_path}models/test.model.js")    
      File.delete("#{@project_path}lib/nin.js") if File.exists?("#{@project_path}lib/nin.js")
      File.delete("#{@project_path}lib/utilities.js") if File.exists?("#{@project_path}lib/utilities.js")
      File.delete("#{@project_path}tests/index.html") if File.exists?("#{@project_path}tests/index.html")
      File.delete("#{@project_path}tests/ninjs.test.js") if File.exists?("#{@project_path}tests/ninjs.test.js")      
      File.delete("#{@project_path}tests/ninjs.utilities.test.js") if File.exists?("#{@project_path}tests/ninjs.utilities.test.js")
      File.delete("#{@project_path}tests/qunit/qunit.css") if File.exists?("#{@project_path}tests/qunit/qunit.css")
      File.delete("#{@project_path}tests/qunit/qunit.js") if File.exists?("#{@project_path}tests/qunit/qunit.js")
      Dir.delete("#{@project_path}tests/qunit") if File.exists?("#{@project_path}tests/qunit")
      File.delete("#{@project_path}modules/global.module.js") if File.exists?("#{@project_path}modules/global.module.js")
      File.delete("#{@project_path}modules/test.module.js") if File.exists?("#{@project_path}modules/test.module.js")

      Ninjs::Manifest.directories.each do |folder|
        Dir.delete("#{@project_path}#{folder}") if File.exists? "#{@project_path}#{folder}"
      end

      Dir.delete('/Volumes/Storage/Development/ninjs/spec/js') if File.exists?('/Volumes/Storage/Development/ninjs/spec/js')
      true.should be_true
    end
    
  end

end
=end