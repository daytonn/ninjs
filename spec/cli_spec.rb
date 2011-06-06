require 'spec_helper'

describe 'CLI' do
  before :each do
    @bin = "#{File.expand_path('../bin')}/ninjs"
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
    FileUtils.rm_rf 'js' if File.exists? 'js'
  end

  it 'should create a new application' do
    suppress_output { `#{@bin} create myapp` }

    'ninjs.conf'.should be_same_file_as 'fixtures/ninjs.conf'

    File.directory?("application").should be_true
    File.directory?("elements").should be_true
    File.directory?("lib").should be_true
    File.directory?("models").should be_true
    File.directory?("modules").should be_true
    File.directory?("plugins").should be_true
    File.directory?("tests").should be_true

    File.exists?(File.expand_path("lib/nin.js")).should be_true
    File.exists?(File.expand_path("lib/utilities.js")).should be_true

    File.exists?(File.expand_path("application/myapp.js")).should be_true
    application_file_content = File.open("application/myapp.js").readlines
    application_file_content.shift
    application_file_content.join('').should == File.open('fixtures/myapp.initial.js').readlines.join('')

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

  it 'should create a new application in a subdirectory' do
    suppress_output { `#{@bin} create myapp js` }

    'js/ninjs.conf'.should be_same_file_as 'fixtures/ninjs.conf'

    File.directory?("js/application").should be_true
    File.directory?("js/elements").should be_true
    File.directory?("js/lib").should be_true
    File.directory?("js/models").should be_true
    File.directory?("js/modules").should be_true
    File.directory?("js/plugins").should be_true
    File.directory?("js/tests").should be_true

    File.exists?(File.expand_path("js/lib/nin.js")).should be_true
    File.exists?(File.expand_path("js/lib/utilities.js")).should be_true

    File.exists?(File.expand_path("js/application/myapp.js")).should be_true
    application_file_content = File.open("js/application/myapp.js").readlines
    application_file_content.shift
    application_file_content.join('').should == File.open('fixtures/myapp.initial.js').readlines.join('')

    File.exists?(File.expand_path("js/tests")).should be_true
    File.exists?(File.expand_path("js/tests/index.html")).should be_true
    File.exists?(File.expand_path("js/tests/application.test.js")).should be_true
    File.exists?(File.expand_path("js/tests/array.utilities.test.js")).should be_true
    File.exists?(File.expand_path("js/tests/existence.test.js")).should be_true
    File.exists?(File.expand_path("js/tests/extension.test.js")).should be_true
    File.exists?(File.expand_path("js/tests/module.test.js")).should be_true
    File.exists?(File.expand_path("js/tests/qspec.js")).should be_true
    File.exists?(File.expand_path("js/tests/string.utilities.test.js")).should be_true
  end
  
  it 'should compile the application' do
    suppress_output { `#{@bin} create myapp` }
    
    FileUtils.cp 'fixtures/hello.module.js', File.expand_path('modules')
    FileUtils.cp 'fixtures/hello.elements.js', File.expand_path('elements')
    FileUtils.cp 'fixtures/hello.model.js', File.expand_path('models')
    FileUtils.cp 'fixtures/foo.module.js', File.expand_path('modules')
    FileUtils.cp 'fixtures/foo.elements.js', File.expand_path('elements')
    FileUtils.cp 'fixtures/foo.model.js', File.expand_path('models')
    
    suppress_output { `#{@bin} compile` }
    
    File.exists?('application/hello.js').should be_true
    File.exists?('application/foo.js').should be_true
  end
  
  it 'should update the application' do
    suppress_output { `#{@bin} create myapp` }
    
    File.open('lib/nin.js', 'w+') do |file|
      file << 'changed'
    end
    
    suppress_output { `#{@bin} update` }
    
    'lib/nin.js'.should be_same_file_as 'fixtures/nin.js'
  end
  
  it 'should generate a module file' do
    suppress_output do
      `#{@bin} create myapp`
      `#{@bin} generate module mymodule`
    end
    
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.module.js'
  end
  
  it 'should generate a module file with an alias' do
    suppress_output do
      `#{@bin} create myapp`
      `#{@bin} generate module mymodule -a`
    end
    
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.alias.module.js'
  end
  
  it 'should generate an elements file' do
    suppress_output do
      `#{@bin} create myapp`
      `#{@bin} generate elements mymodule`
    end
    
    'elements/mymodule.elements.js'.should be_same_file_as 'fixtures/mymodule.elements.js'
  end
  
  it 'should generate a model file' do
    suppress_output do
      `#{@bin} create myapp`
      `#{@bin} generate model mymodule`
    end
    
    'models/mymodule.model.js'.should be_same_file_as 'fixtures/mymodule.model.js'
  end
  
  it 'should generate a module file with dependencies' do
    suppress_output do
      `#{@bin} create myapp`
      `#{@bin} generate module mymodule -em`
    end
    
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.dependencies.module.js'
    'elements/mymodule.elements.js'.should be_same_file_as 'fixtures/mymodule.elements.js'
    'models/mymodule.model.js'.should be_same_file_as 'fixtures/mymodule.model.js'
  end

end