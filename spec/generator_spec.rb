require "spec_helper"

describe Ninjs::Generator do
  before :each do
    @config = {
      :project => Ninjs::Project.new('myapp'),
      :type => 'module',
      :name => 'mymodule',
      :alias => nil,
      :dest => 'application',
      :src => 'elements',
      :dependencies => { :elements => false, :model => false }
    }
    
    @test_dirs = %w(modules elements models)
    @test_dirs.each do |dir|
      FileUtils.mkdir(dir)
    end
    
    File.open('ninjs.conf', 'w+') do |file|
      file << File.open('fixtures/ninjs.conf').readlines.join('')
    end
  end
  
  after :each do
    FileUtils.rm_rf 'ninjs.conf'
    @test_dirs.each do |dir|
      FileUtils.rm_rf dir
    end
  end
  
  it 'should should generate a module file' do
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }
    
    File.open(File.expand_path('modules/mymodule.module.js')).should be_true
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.module.js'
  end
  
  it 'should generate a module with an alias' do
    @config[:type] = 'module'
    @config[:alias] = 'app'
    
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }
    
    File.open(File.expand_path('modules/mymodule.module.js')).should be_true
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.alias.module.js'
  end

  it 'should should generate an elements file' do
    @config[:type] = 'elements'
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }
    
    File.open(File.expand_path('elements/mymodule.elements.js')).should be_true
    'elements/mymodule.elements.js'.should be_same_file_as 'fixtures/mymodule.elements.js'
  end

  it 'should should generate a model file' do
    @config[:type] = 'model'
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }
    
    File.open(File.expand_path('models/mymodule.model.js')).should be_true
    'models/mymodule.model.js'.should be_same_file_as 'fixtures/mymodule.model.js'
  end

  it 'should generate a module file with dependencies' do
    generator = Ninjs::Generator.new({
      :project => Ninjs::Project.new('myapp'),
      :type => 'module',
      :name => 'mymodule',
      :alias => nil,
      :dest => 'application',
      :src => 'modules',
      :dependencies => { :elements => true, :model => true }
    })
    suppress_output { generator.generate }
    
    File.open(File.expand_path('modules/mymodule.module.js')).should be_true
    'modules/mymodule.module.js'.should be_same_file_as 'fixtures/mymodule.dependencies.module.js'
    
    File.open(File.expand_path('elements/mymodule.elements.js')).should be_true
    'elements/mymodule.elements.js'.should be_same_file_as 'fixtures/mymodule.elements.js'
    
    File.open(File.expand_path('models/mymodule.model.js')).should be_true
    'models/mymodule.model.js'.should be_same_file_as 'fixtures/mymodule.model.js'
  end

end