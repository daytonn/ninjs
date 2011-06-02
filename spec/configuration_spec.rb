require "spec_helper"

describe Ninjs::Configuration do
  context 'Instantiation' do
    before :each do
      suppress_output { @config = Ninjs::Configuration.new File.expand_path(Dir.getwd) }
    end

    it 'should exist' do
      Ninjs::Configuration.should_not be_nil
    end

    it 'should have a root variable' do
      @config.root.should == File.expand_path(Dir.getwd)
    end

    it 'should have a setting setter method' do
      @config.setting(:name, 'someapp')
      @config.name.should == 'someapp'
    end

    it 'should have a settings hash' do
      @config.settings.has_key?(:name).should be_true
      @config.settings[:name].should == 'application'

      @config.settings.has_key?(:src_dir).should be_true
      @config.settings[:src_dir].should == 'modules'

      @config.settings.has_key?(:dest_dir).should be_true
      @config.settings[:dest_dir].should == 'application'

      @config.settings.has_key?(:output).should be_true
      @config.settings[:output].should == 'expanded'

      @config.settings.has_key?(:dependencies).should be_true
      @config.settings[:dependencies].should == ['<jquery/latest>']

      @config.settings.has_key?(:autoload).should be_true
      @config.settings[:autoload].should == ['../lib/utilities']
    end
    
    it 'should have the correct default instance variables' do
      @config.root.should == File.expand_path(Dir.getwd)
      @config.name.should == 'application'
      @config.output.should == "expanded"
      @config.asset_root.should == @config.root
      @config.dependencies.should == ["<jquery/latest>"]
      @config.autoload.should == ["../lib/utilities"]
      @config.src_dir.should == "modules"
      @config.dest_dir.should == "application"
    end
  end
  
  context "New config" do
    before :each do
      suppress_output do
        @config = Ninjs::Configuration.new File.expand_path(Dir.getwd)
        @config.write
      end
    end
    
    after :each do
      File.delete 'ninjs.conf'
    end
    
    it 'should create a configuration file from defaults' do
      'ninjs.conf'.should be_same_file_as 'fixtures/new.ninjs.conf'
    end
  end
end