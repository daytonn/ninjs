require "spec_helper"

describe Ninjs::Command do  
  
  context 'API' do
    before :each do
      suppress_output do
        @project = Ninjs::Project.new({ name: 'myapp', root: SPEC_DIR })
        @project.create
      end
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
    end

    it 'should have a watch command' do
      Ninjs::Command.should respond_to :watch
    end

    it 'should have a compile command' do
      Ninjs::Command.should respond_to :compile
    end

    it 'should have a generate command' do
      Ninjs::Command.should respond_to :generate
    end

    it 'should have a create command' do
      Ninjs::Command.should respond_to :create
    end

    it 'should have an update command' do
      Ninjs::Command.should respond_to :update
    end
  end
  
  context 'Usage' do
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
      suppress_output { Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR }) }

      "#{SPEC_DIR}/ninjs.conf".should be_same_file_as "#{SPEC_DIR}/fixtures/ninjs.conf"

      File.directory?("#{SPEC_DIR}/application").should be_true
      File.directory?("#{SPEC_DIR}/elements").should be_true
      File.directory?("#{SPEC_DIR}/lib").should be_true
      File.directory?("#{SPEC_DIR}/models").should be_true
      File.directory?("#{SPEC_DIR}/modules").should be_true
      File.directory?("#{SPEC_DIR}/plugins").should be_true
      File.directory?("#{SPEC_DIR}/tests").should be_true

      File.exists?("#{SPEC_DIR}/lib/nin.js").should be_true
      File.exists?("#{SPEC_DIR}/lib/utilities.js").should be_true

      File.exists?("#{SPEC_DIR}/application/myapp.js").should be_true
      application_file_content = File.open("#{SPEC_DIR}/application/myapp.js").readlines
      application_file_content.shift
      application_file_content.join('').should == File.open("#{SPEC_DIR}/fixtures/myapp.initial.js").readlines.join('')

      File.exists?("#{SPEC_DIR}/tests").should be_true
      File.exists?("#{SPEC_DIR}/tests/index.html").should be_true
      File.exists?("#{SPEC_DIR}/tests/application.test.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/array.utilities.test.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/existence.test.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/extension.test.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/module.test.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/qspec.js").should be_true
      File.exists?("#{SPEC_DIR}/tests/string.utilities.test.js").should be_true
    end

    it 'should compile the application' do
      suppress_output { Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR }) }
      
      FileUtils.cp "#{SPEC_DIR}/fixtures/hello.module.js", "#{SPEC_DIR}/modules"
      FileUtils.cp "#{SPEC_DIR}/fixtures/hello.elements.js", "#{SPEC_DIR}/elements"
      FileUtils.cp "#{SPEC_DIR}/fixtures/hello.model.js", "#{SPEC_DIR}/models"
      FileUtils.cp "#{SPEC_DIR}/fixtures/foo.module.js", "#{SPEC_DIR}/modules"
      FileUtils.cp "#{SPEC_DIR}/fixtures/foo.elements.js", "#{SPEC_DIR}/elements"
      FileUtils.cp "#{SPEC_DIR}/fixtures/foo.model.js", "#{SPEC_DIR}/models"

      suppress_output { Ninjs::Command.compile({ path: SPEC_DIR }) }

      File.exists?("#{SPEC_DIR}/application/hello.js").should be_true
      File.exists?("#{SPEC_DIR}/application/foo.js").should be_true
    end

    it 'should update the application' do
      suppress_output { Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR }) }

      File.open("#{SPEC_DIR}/lib/nin.js", 'w+') do |file|
        file << 'changed'
      end

      suppress_output { Ninjs::Command.update(SPEC_DIR) }

      "#{SPEC_DIR}/lib/nin.js".should be_same_file_as "#{SPEC_DIR}/fixtures/nin.js"
    end
    
    it 'should generate a module file' do
      suppress_output do
        Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR })
        Ninjs::Command.generate({
          project: Ninjs::Project.new({ root: SPEC_DIR }),
          type: 'module',
          name: 'mymodule',
          alias: nil,
          dest: nil,
          dependencies: nil
        })
      end
      
      "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.module.js"
    end
    
    it 'should generate a module file with an alias' do
      suppress_output do
        Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR })
        Ninjs::Command.generate({
          project: Ninjs::Project.new({ root: SPEC_DIR }),
          type: 'module',
          name: 'mymodule',
          alias: 'app',
          dest: nil,
          dependencies: nil
        })
      end
      
      "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.alias.module.js"
    end
    
    it 'should generate an elements file' do
      suppress_output do
        Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR })
        Ninjs::Command.generate({
          project: Ninjs::Project.new({ root: SPEC_DIR }),
          type: 'elements',
          name: 'mymodule',
          alias: nil,
          dest: nil,
          dependencies: nil
        })
      end
      
      "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
    end
    
    it 'should generate a model file' do
      suppress_output do
        Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR })
        Ninjs::Command.generate({
          project: Ninjs::Project.new({ root: SPEC_DIR }),
          type: 'model',
          name: 'mymodule',
          alias: nil,
          dest: nil,
          dependencies: nil
        })
      end
      
      "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
    end
    
    it 'should generate a module file with dependencies' do
      suppress_output do
        Ninjs::Command.create({ name: 'myapp', root: SPEC_DIR })
        Ninjs::Command.generate({
          project: Ninjs::Project.new({ root: SPEC_DIR }),
          type: 'module',
          name: 'mymodule',
          alias: nil,
          dest: nil,
          dependencies: { elements: true, model: true }
        })
      end
      
      "#{SPEC_DIR}/modules/mymodule.module.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.dependencies.module.js"
      "#{SPEC_DIR}/elements/mymodule.elements.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.elements.js"
      "#{SPEC_DIR}/models/mymodule.model.js".should be_same_file_as "#{SPEC_DIR}/fixtures/mymodule.model.js"
    end
  end # Usage
end