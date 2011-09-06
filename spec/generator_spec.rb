require "spec_helper"

describe Ninjs::Generator do
  before :each do
    @config = {
      project: Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR }),
      type: 'module',
      name: 'mymodule',
      alias: nil,
      dest: 'application',
      src: 'elements',
      dependencies: { elements: false, model: false }
    }
    
    @test_dirs = %w(modules elements models)
    @test_dirs.each do |dir|
      FileUtils.mkdir("#{SPEC_DIR}/#{dir}")
    end
    
    File.open("#{SPEC_DIR}/ninjs.conf", 'w+') do |file|
      file << File.open("#{SPEC_DIR}/fixtures/ninjs.conf").readlines.join('')
    end
  end
  
  after :each do
    FileUtils.rm_rf "#{SPEC_DIR}/ninjs.conf"
    @test_dirs.each do |dir|
      FileUtils.rm_rf "#{SPEC_DIR}/#{dir}"
    end
  end
  
  it 'should should generate a module file' do
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }

    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.module.js"
  end
  
  it 'should generate a module with an alias' do
    @config[:type] = 'module'
    @config[:alias] = 'app'
    
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }

    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.alias.module.js"
  end

  it 'should should generate an elements file' do
    @config[:type] = 'elements'
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }

    "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
  end

  it 'should should generate a model file' do
    @config[:type] = 'model'
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }

    "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
  end

  it 'should generate a module file with dependencies' do
    generator = Ninjs::Generator.new({
      project: Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR}),
      type: 'module',
      name: 'mymodule',
      alias: nil,
      dest: 'application',
      src: 'modules',
      dependencies: { elements: true, model: true }
    })
    suppress_output { generator.generate }

    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.dependencies.module.js"
    "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
    "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
  end

  it 'should generate a module file with a dynamic alias' do
    new_conf = File.open("#{SPEC_DIR}/fixtures/updated.ninjs.conf", "r").readlines.join("")
    File.open("#{SPEC_DIR}/ninjs.conf", "w+") do |file|
      file << new_conf
    end
    @config[:project].config.read
    generator = Ninjs::Generator.new(@config)
    suppress_output { generator.generate }
    
    "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.module_alias.module.js"
  end
end