require 'spec_helper'

describe 'CLI' do
  before :each do
    @bin = "#{Ninjs::BASE_DIR}/bin/ninjs"
  end

	after :each do
    FileUtils.rm_rf "#{SPEC_DIR}/application"
    FileUtils.rm_rf "#{SPEC_DIR}/modules"
    FileUtils.rm_rf "#{SPEC_DIR}/elements"
    FileUtils.rm_rf "#{SPEC_DIR}/models"
    FileUtils.rm_rf "#{SPEC_DIR}/lib"
    FileUtils.rm_rf "#{SPEC_DIR}/plugins"
    FileUtils.rm_rf "#{SPEC_DIR}/tests"
    FileUtils.rm_rf "#{SPEC_DIR}/ninjs.conf"
    FileUtils.rm_rf "#{SPEC_DIR}/js" if File.exists? "#{SPEC_DIR}/js"
  end

  it 'should create a new application' do
    suppress_output do
      %x(cd #{SPEC_DIR}; #{@bin} create myapp)
    end

    "#{SPEC_DIR}/ninjs.conf".should be_same_file_as "#{SPEC_DIR}/fixtures/ninjs.conf"

    File.directory?("#{SPEC_DIR}/application").should be_true
    File.directory?("#{SPEC_DIR}/elements").should be_true
    File.directory?("#{SPEC_DIR}/lib").should be_true
    File.directory?("#{SPEC_DIR}/models").should be_true
    File.directory?("#{SPEC_DIR}/modules").should be_true
    File.directory?("#{SPEC_DIR}/plugins").should be_true
    File.directory?("#{SPEC_DIR}/spec").should be_true
    File.directory?("#{SPEC_DIR}/spec/javascripts").should be_true
    File.directory?("#{SPEC_DIR}/spec/javascripts/support").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/application_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/array_utility_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/existence_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/extension_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/module_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/string_utility_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine.yml").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_config.rb").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_runner.rb").should be_true

    File.exists?("#{SPEC_DIR}/lib/nin.js").should be_true
    File.exists?("#{SPEC_DIR}/lib/utilities.js").should be_true

    File.exists?("#{SPEC_DIR}/application/myapp.js").should be_true
    application_file_content = File.open("#{SPEC_DIR}/application/myapp.js").readlines
    application_file_content.shift
    application_file_content.join('').should == File.open("#{SPEC_DIR}/fixtures/myapp.initial.js").readlines.join('')
  end

  it 'should create a new application in a subdirectory' do
    suppress_output { %x(cd #{SPEC_DIR} && #{@bin} create myapp js) }
    
    "#{SPEC_DIR}/js/ninjs.conf".should be_same_file_as "#{SPEC_DIR}/fixtures/ninjs.conf"

    File.directory?("#{SPEC_DIR}/js/application").should be_true
    File.directory?("#{SPEC_DIR}/js/elements").should be_true
    File.directory?("#{SPEC_DIR}/js/lib").should be_true
    File.directory?("#{SPEC_DIR}/js/models").should be_true
    File.directory?("#{SPEC_DIR}/js/modules").should be_true
    File.directory?("#{SPEC_DIR}/js/plugins").should be_true
    File.directory?("#{SPEC_DIR}/spec").should be_true
    File.directory?("#{SPEC_DIR}/spec/javascripts").should be_true
    File.directory?("#{SPEC_DIR}/spec/javascripts/support").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/application_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/array_utility_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/existence_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/extension_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/module_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/string_utility_spec.js").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine.yml").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_config.rb").should be_true
    File.exists?("#{SPEC_DIR}/spec/javascripts/support/jasmine_runner.rb").should be_true
    File.exists?("#{SPEC_DIR}/js/lib/nin.js").should be_true
    File.exists?("#{SPEC_DIR}/js/lib/utilities.js").should be_true
    File.exists?("#{SPEC_DIR}/js/application/myapp.js").should be_true
    application_file_content = File.open("#{SPEC_DIR}/js/application/myapp.js").readlines
    application_file_content.shift
    application_file_content.join('').should == File.open("#{SPEC_DIR}/fixtures/myapp.initial.js").readlines.join('')
  end
  
  it 'should compile the application' do
    suppress_output { %x(cd #{SPEC_DIR} && #{@bin} create myapp) }
    
    FileUtils.cp "#{SPEC_DIR}/fixtures/hello.module.js", "#{SPEC_DIR}/modules"
    FileUtils.cp "#{SPEC_DIR}/fixtures/hello.elements.js", "#{SPEC_DIR}/elements"
    FileUtils.cp "#{SPEC_DIR}/fixtures/hello.model.js", "#{SPEC_DIR}/models"
    FileUtils.cp "#{SPEC_DIR}/fixtures/foo.module.js", "#{SPEC_DIR}/modules"
    FileUtils.cp "#{SPEC_DIR}/fixtures/foo.elements.js", "#{SPEC_DIR}/elements"
    FileUtils.cp "#{SPEC_DIR}/fixtures/foo.model.js", "#{SPEC_DIR}/models"
    
    suppress_output { %x(cd #{SPEC_DIR} && #{@bin} compile) }
    
    File.exists?("#{SPEC_DIR}/application/hello.js").should be_true
    File.exists?("#{SPEC_DIR}/application/foo.js").should be_true
  end
  
  it 'should update the application' do
    suppress_output { %x(cd #{SPEC_DIR} && #{@bin} create myapp) }
    
    File.open("#{SPEC_DIR}/lib/nin.js", 'w+') do |file|
      file << 'changed'
    end
    
    suppress_output { %x(cd #{SPEC_DIR} && #{@bin} update) }
    
    "#{SPEC_DIR}/lib/nin.js".should be_same_file_as "#{SPEC_DIR}/fixtures/nin.js"
  end
  
  it 'should generate a module file' do
    suppress_output do
      %x(cd #{SPEC_DIR} && #{@bin} create myapp)
      %x(cd #{SPEC_DIR} && #{@bin} generate module mymodule)
    end
    
    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.module.js"
  end
  
  it 'should generate a module file with an alias' do
    suppress_output do
      %x(cd #{SPEC_DIR} && #{@bin} create myapp)
      %x(cd #{SPEC_DIR} && #{@bin} generate module mymodule -a)
    end
    
    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.alias.module.js"
  end
  
  it 'should generate an elements file' do
    suppress_output do
      %x(cd #{SPEC_DIR} && #{@bin} create myapp)
      %x(cd #{SPEC_DIR} && #{@bin} generate elements mymodule)
    end
    
    "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
  end
  
  it 'should generate a model file' do
    suppress_output do
      %x(cd #{SPEC_DIR} && #{@bin} create myapp)
      %x(cd #{SPEC_DIR} && #{@bin} generate model mymodule)
    end
    
    "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
  end
  
  it 'should generate a module file with dependencies' do
    suppress_output do
      %x(cd #{SPEC_DIR} && #{@bin} create myapp)
      %x(cd #{SPEC_DIR} && #{@bin} generate module mymodule -em)
    end
    
    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.dependencies.module.js"
    "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
    "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
  end

end