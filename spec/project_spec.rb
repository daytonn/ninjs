require "spec_helper.rb"

describe Ninjs::Project do

  it "should exist" do
    Ninjs::Project.should_not be_nil
  end

  it "should have a @root setter method" do
    suppress_output { @project = Ninjs::Project.new({ name: 'myapp' }) }
    @project.root = SPEC_DIR
    @project.root.should == SPEC_DIR
  end

  context 'Instantiation without an existing config file' do
    before :each do
      suppress_output do
        @project = Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR })
      end
    end

    after :each do
      File.delete "#{SPEC_DIR}/ninjs.conf" if File.exists? "#{SPEC_DIR}/ninjs.conf"
    end

    it 'should raise an error if initialized without a name' do
      File.delete "#{SPEC_DIR}/ninjs.conf" if File.exists? "#{SPEC_DIR}/ninjs.conf"
      lambda{ project = Ninjs::Project.new(root: SPEC_DIR) }.should raise_error(ArgumentError)
   end

   it 'should have a root variable' do
     @project.root.should == SPEC_DIR
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
  end # Instantiation without an existing config file

  context "Instantiation with an existing config file" do
   before :each do
     File.open "#{SPEC_DIR}/ninjs.conf", 'w' do |file|
       file << %Q{name: something\noutput: expanded\ndependencies: ["<jquery/latest>"]\nautoload: ["../lib/utilities"]\nsrc_dir: classes\ndest_dir: compiled}
     end

     @project = Ninjs::Project.new({ root: SPEC_DIR })
   end

   after :each do
     File.delete "#{SPEC_DIR}/ninjs.conf"
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
  end # Instantiation with an existing config file

  context "Project Creation" do
   before :each do
     suppress_output do
       @project = Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR })
       @project.create_project_scaffold
     end
   end

   after :each do
     FileUtils.rm_rf "#{SPEC_DIR}/application"
     FileUtils.rm_rf "#{SPEC_DIR}/elements"
     FileUtils.rm_rf "#{SPEC_DIR}/lib"
     FileUtils.rm_rf "#{SPEC_DIR}/models"
     FileUtils.rm_rf "#{SPEC_DIR}/modules"
     FileUtils.rm_rf "#{SPEC_DIR}/plugins"
     FileUtils.rm_rf "#{SPEC_DIR}/spec"
     FileUtils.rm_rf "#{SPEC_DIR}/Rakefile"
   end

   it 'should create a project directory structure' do
     File.directory?("#{SPEC_DIR}/application").should be_true
     File.directory?("#{SPEC_DIR}/elements").should be_true
     File.directory?("#{SPEC_DIR}/lib").should be_true
     File.directory?("#{SPEC_DIR}/models").should be_true
     File.directory?("#{SPEC_DIR}/modules").should be_true
     File.directory?("#{SPEC_DIR}/plugins").should be_true
     File.directory?("#{SPEC_DIR}/spec").should be_true
   end

   it 'should create a ninjs lib file' do
     suppress_output { @project.create_ninjs_lib_file }
     File.exists?("#{SPEC_DIR}/lib/nin.js").should be_true
     "#{SPEC_DIR}/lib/nin.js".should be_same_file_as "#{SPEC_DIR}/fixtures/nin.js"
   end

   it 'should create a utilities file' do
     suppress_output { @project.create_utility_lib_file }
     File.exists?("#{SPEC_DIR}/lib/utilities.js").should be_true
   end

   it 'should create an application file' do
     suppress_output do
       @project.create_ninjs_lib_file
       @project.create_ninjs_application_file
     end

     File.exists?("#{SPEC_DIR}/application/myapp.js").should be_true
     application_file_content = File.open("#{SPEC_DIR}/application/myapp.js").readlines
     application_file_content.shift
     application_file_content.join('').should == File.open("#{SPEC_DIR}/fixtures/myapp.initial.js").readlines.join('')
   end

    it 'should import spec files' do
      suppress_output { @project.import_spec_files }

      File.directory?("#{SPEC_DIR}/spec").should be_true
      File.directory?("#{SPEC_DIR}/spec/javascripts").should be_true
      File.directory?("#{SPEC_DIR}/spec/javascripts/support").should be_true
      File.exists?("#{SPEC_DIR}/spec/index.html").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/application_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/array_utility_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/existence_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/extension_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/module_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/string_utility_spec.js").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine.yml").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_config.rb").should be_true
      File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_runner.rb").should be_true
    end
    
    it 'should import the Rakefile' do
      suppress_output { @project.import_rakefile }
      File.exists?("#{SPEC_DIR}/Rakefile").should be_true
    end
  end # Project Creation
=begin
  context 'Project management' do
   before :each do
     suppress_output do
       @project = Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR })
       @project.create
     end

     FileUtils.cp "#{SPEC_DIR}/fixtures/hello.module.js", "#{SPEC_DIR}/modules"
     FileUtils.cp "#{SPEC_DIR}/fixtures/hello.elements.js", "#{SPEC_DIR}/elements"
     FileUtils.cp "#{SPEC_DIR}/fixtures/hello.model.js", "#{SPEC_DIR}/models"
     FileUtils.cp "#{SPEC_DIR}/fixtures/foo.module.js", "#{SPEC_DIR}/modules"
     FileUtils.cp "#{SPEC_DIR}/fixtures/foo.elements.js", "#{SPEC_DIR}/elements"
     FileUtils.cp "#{SPEC_DIR}/fixtures/foo.model.js", "#{SPEC_DIR}/models"
     FileUtils.cp "#{SPEC_DIR}/fixtures/_global.module.js", "#{SPEC_DIR}/modules"
   end

   after :each do
     FileUtils.rm_rf "#{SPEC_DIR}/application"
     FileUtils.rm_rf "#{SPEC_DIR}/modules"
     FileUtils.rm_rf "#{SPEC_DIR}/elements"
     FileUtils.rm_rf "#{SPEC_DIR}/models"
     FileUtils.rm_rf "#{SPEC_DIR}/lib"
     FileUtils.rm_rf "#{SPEC_DIR}/plugins"
     FileUtils.rm_rf "#{SPEC_DIR}/spec"
     FileUtils.rm_rf "#{SPEC_DIR}/ninjs.conf"
     FileUtils.rm_rf "#{SPEC_DIR}/Rakefile"
   end

   it 'should create a config file' do
     "#{SPEC_DIR}/ninjs.conf".should be_same_file_as "#{SPEC_DIR}/fixtures/ninjs.conf"
   end

   it 'should get modules' do
     @project.get_modules
     @project.modules.include?("#{SPEC_DIR}/modules/foo.module.js").should be_true
     @project.modules.include?("#{SPEC_DIR}/modules/hello.module.js").should be_true
   end

   it 'should compile a module' do
     @project.compile_module "#{SPEC_DIR}/modules/hello.module.js", 'hello'
     File.exists?("#{SPEC_DIR}/application/hello.js").should be_true
     "#{SPEC_DIR}/application/hello.js".should be_same_file_as "#{SPEC_DIR}/fixtures/hello.js"
   end

   it 'should add modules from a directory' do
     @project.add_scripts_to_models("#{SPEC_DIR}/modules")
     @project.modules.include?("#{SPEC_DIR}/modules/foo.module.js").should be_true
     @project.modules.include?("#{SPEC_DIR}/modules/hello.module.js").should be_true
   end

   it 'should compile the modules' do
     @project.add_scripts_to_models("#{SPEC_DIR}/modules")
     @project.compile_modules

     "#{SPEC_DIR}/application/hello.js".should be_same_file_as "#{SPEC_DIR}/fixtures/hello.js"
     "#{SPEC_DIR}/application/foo.js".should be_same_file_as "#{SPEC_DIR}/fixtures/foo.js"
   end

   it 'should not compile prefixed modules' do
     @project.add_scripts_to_models("#{SPEC_DIR}/modules")
     @project.compile_modules

     File.exists?("#{SPEC_DIR}/application/_global.js").should_not be_true
   end

   it 'should write the dependencies to a file' do
     FileUtils.touch "#{SPEC_DIR}/dependencies.js"

     File.open("#{SPEC_DIR}/dependencies.js", 'w') do |file|
       @project.write_dependencies(file)
     end

     "#{SPEC_DIR}/dependencies.js".should be_same_file_as "#{SPEC_DIR}/fixtures/dependencies.js"

     File.delete "#{SPEC_DIR}/dependencies.js"
   end

   it 'should write the core to a file' do
     FileUtils.touch "#{SPEC_DIR}/core.js"

     File.open("#{SPEC_DIR}/core.js", 'w') do |file|
       @project.write_core(file)
     end

     "#{SPEC_DIR}/core.js".should be_same_file_as "#{SPEC_DIR}/fixtures/core.js"

     File.delete "#{SPEC_DIR}/core.js"
   end

   it 'should write the autoloaded files to a file' do
     FileUtils.touch "#{SPEC_DIR}/autoload.js"

     File.open("#{SPEC_DIR}/autoload.js", 'w') do |file|
       @project.write_autoload(file)
     end

     "#{SPEC_DIR}/autoload.js".should be_same_file_as "#{SPEC_DIR}/fixtures/autoload.js"

     File.delete "#{SPEC_DIR}/autoload.js"
   end

   it 'should update the application file' do
     suppress_output { @project.update_application_file }
     "#{SPEC_DIR}/application/myapp.js".should be_same_file_as "#{SPEC_DIR}/fixtures/myapp.js"
   end

   it 'should compress an application' do
     @project.config.dest_dir = 'spec/application'
     @project.compress_application
     "#{SPEC_DIR}/application/myapp.js".should be_same_file_as "#{SPEC_DIR}/fixtures/compressed.myapp.js"
   end

  end # Project management
=end
end