require "spec_helper.rb"

describe Ninjs::Project do
  it "should exist" do
    Ninjs::Project.should_not be_nil
  end
  
  it "should have a @root setter method" do
    suppress_output { @project = Ninjs::Project.new 'myapp' }
    @project.root = File.expand_path(Dir.getwd)
    @project.root.should == File.expand_path(Dir.getwd)
  end
  
  context 'Instantiation without an existing config file' do
    before :each do
      suppress_output { @project = Ninjs::Project.new 'myapp' }
    end
    
    after :each do
      File.delete 'ninjs.conf' if File.exists? 'ninjs.conf'
    end
    
    it 'should raise an error if initialized without a name' do
      File.delete 'ninjs.conf' if File.exists? 'ninjs.conf'
      lambda{ project = Ninjs::Project.new }.should raise_error(ArgumentError)
    end
    
    it 'should have a root variable' do
      @project.root.should == File.expand_path(Dir.getwd)
    end
    
    it 'should have an empty modules array' do
      @project.modules.should == Array.new
    end
    
    it 'should have a config object' do
      @project.config.should_not be_nil
    end
    
    it 'should set the config.name property' do
      @project.config.name.should == 'myapp'
    end
  end
 
  context "Instantiation with an existing config file" do
    before :each do
      File.open File.expand_path("ninjs.conf"), 'w' do |file|
        file << %Q{name: something\noutput: expanded\ndependencies: ["<jquery/latest>"]\nautoload: ["../lib/utilities"]\nsrc_dir: classes\ndest_dir: compiled}
      end
      @project = Ninjs::Project.new
    end
    
    after :each do
      File.delete "ninjs.conf"
    end
    
    it 'should have a valid config object' do
      @project.config.should_not be_nil
      @project.config.name.should == 'something'
      @project.config.output.should == 'expanded'
      @project.config.dependencies.should == ["<jquery/latest>"]
      @project.config.autoload.should == ["../lib/utilities"]
      @project.config.src_dir.should == 'classes'
      @project.config.dest_dir.should == 'compiled'
    end
  end

  context "Project Creation" do
    before :each do
      suppress_output do
        @project = Ninjs::Project.new 'myapp'
        @project.create_project_scaffold
      end
    end
   
    after :each do
      FileUtils.rm_rf "application"
      FileUtils.rm_rf "elements"
      FileUtils.rm_rf "lib"
      FileUtils.rm_rf "models"
      FileUtils.rm_rf "modules"
      FileUtils.rm_rf "plugins"
      FileUtils.rm_rf "tests"
    end
    
    it 'should create a project directory structure' do
      File.directory?("application").should be_true
      File.directory?("elements").should be_true
      File.directory?("lib").should be_true
      File.directory?("models").should be_true
      File.directory?("modules").should be_true
      File.directory?("plugins").should be_true
      File.directory?("tests").should be_true
    end
    
    it 'should create a ninjs lib file' do
      suppress_output { @project.create_ninjs_lib_file }
      File.exists?(File.expand_path("lib/nin.js")).should be_true
      'lib/nin.js'.should be_same_file_as 'fixtures/nin.js'
    end
    
    it 'should create a utilities file' do
      suppress_output { @project.create_utility_lib_file }
      File.exists?(File.expand_path("lib/utilities.js")).should be_true
    end
    
    it 'should create an application file' do
      suppress_output do
        @project.create_ninjs_lib_file
        @project.create_ninjs_application_file
      end
      
      File.exists?(File.expand_path("application/myapp.js")).should be_true
      application_file_content = File.open("application/myapp.js").readlines
      application_file_content.shift
      application_file_content.join('').should == File.open('fixtures/myapp.initial.js').readlines.join('')
    end
    
    it 'should import test files' do
      suppress_output { @project.import_test_files }

      File.exists?(File.expand_path("tests")).should be_true
      File.exists?(File.expand_path("tests/index.html")).should be_true
      File.exists?(File.expand_path("tests/application.test.js")).should be_true
      File.exists?(File.expand_path("tests/array.utilities.test.js")).should be_true
      File.exists?(File.expand_path("tests/existence.test.js")).should be_true
      File.exists?(File.expand_path("tests/extension.test.js")).should be_true
      File.exists?(File.expand_path("tests/module.test.js")).should be_true
      File.exists?(File.expand_path("tests/qspec.js")).should be_true
      File.exists?(File.expand_path("tests/string.utilities.test.js")).should be_true
    end
  end

  context 'Project management' do
    before :each do
      suppress_output do
        @project = Ninjs::Project.new 'myapp'
        @project.create
      end
           
      FileUtils.cp 'fixtures/hello.module.js', File.expand_path('modules')
      FileUtils.cp 'fixtures/hello.elements.js', File.expand_path('elements')
      FileUtils.cp 'fixtures/hello.model.js', File.expand_path('models')
      FileUtils.cp 'fixtures/foo.module.js', File.expand_path('modules')
      FileUtils.cp 'fixtures/foo.elements.js', File.expand_path('elements')
      FileUtils.cp 'fixtures/foo.model.js', File.expand_path('models')
    end
   
    after :each do
      FileUtils.rm_rf 'application'
      FileUtils.rm_rf 'modules'
      FileUtils.rm_rf 'elements'
      FileUtils.rm_rf 'models'
      FileUtils.rm_rf 'lib'
      FileUtils.rm_rf 'plugins'
      FileUtils.rm_rf 'tests'
      FileUtils.rm_rf 'ninjs.conf'
    end
    
    it 'should create a config file' do
      'ninjs.conf'.should be_same_file_as 'fixtures/ninjs.conf'
    end
    
    it 'should get modules' do
      @project.get_modules
      @project.modules.should == [
        "/Volumes/Storage/Development/ninjs/spec/modules/foo.module.js",
        "/Volumes/Storage/Development/ninjs/spec/modules/hello.module.js"
      ]
    end
    
    it 'should compile a module' do
      @project.compile_module File.expand_path('modules/hello.module.js'), 'hello'
      File.exists?('application/hello.js').should be_true
      'application/hello.js'.should be_same_file_as 'fixtures/hello.js'
    end
    
    it 'should add modules from a directory' do
      @project.add_scripts_to_models(File.expand_path('modules'))
      
      @project.modules.should == [
        '/Volumes/Storage/Development/ninjs/spec/modules/foo.module.js',
        '/Volumes/Storage/Development/ninjs/spec/modules/hello.module.js'
      ]
    end
    
    it 'should compile the modules' do
      @project.add_scripts_to_models(File.expand_path('modules'))
      @project.compile_modules

      'application/hello.js'.should be_same_file_as 'fixtures/hello.js'
      'application/foo.js'.should be_same_file_as 'fixtures/foo.js'
    end
    
    it 'should write the dependencies to a file' do
      FileUtils.touch 'dependencies.js'
      
      File.open(File.expand_path('dependencies.js'), 'w') do |file|
        @project.write_dependencies(file)
      end
      
      'dependencies.js'.should be_same_file_as 'fixtures/dependencies.js'
      
      File.delete 'dependencies.js'
    end
    
    it 'should write the core to a file' do
      FileUtils.touch 'core.js'
      
      File.open('core.js', 'w') do |file|
        @project.write_core(file)
      end
      
      'core.js'.should be_same_file_as 'fixtures/core.js'
      
      File.delete 'core.js'
    end
    
    it 'should write the autoloaded files to a file' do
      FileUtils.touch 'autoload.js'
      
      File.open('autoload.js', 'w') do |file|
        @project.write_autoload(file)
      end
      
      'autoload.js'.should be_same_file_as 'fixtures/autoload.js'
      
      File.delete 'autoload.js'
    end
    
    it 'should update the application file' do
      suppress_output { @project.update_application_file }
      'application/myapp.js'.should be_same_file_as 'fixtures/myapp.js'
    end
    
    it 'should compress an application' do
      @project.compress_application
      'application/myapp.js'.should be_same_file_as 'fixtures/compressed.myapp.js'
    end
    
  end

end