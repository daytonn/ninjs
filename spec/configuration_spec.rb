require "spec_helper"

describe Ninjs::Configuration do
  context 'Instantiation' do
    before :each do
      suppress_output { @config = Ninjs::Configuration.new SPEC_DIR }
    end

    it 'should exist' do
      Ninjs::Configuration.should_not be_nil
    end

    it 'should have a root variable' do
      @config.root.should == SPEC_DIR
    end

    it 'should have the correct default instance variables' do
      @config.root.should == SPEC_DIR
      @config.name.should == 'application'
      @config.output.should == "expanded"
      @config.asset_root.should == File.expand_path('../', SPEC_DIR)
      @config.dependencies.should == ["<jquery/latest>"]
      @config.autoload.should == ["../lib/utilities"]
      @config.src_dir.should == "modules"
      @config.dest_dir.should == "application"
    end
  end # Instantiation

  context "New config" do
    before :each do
      suppress_output do
        @config = Ninjs::Configuration.new SPEC_DIR
        @config.write
      end
    end

    after :each do
      File.delete "#{SPEC_DIR}/ninjs.conf"
    end

    it 'should create a configuration file from defaults' do
      "#{SPEC_DIR}/ninjs.conf".should be_same_file_as "#{SPEC_DIR}/fixtures/new.ninjs.conf"
    end
    
    it 'should read properties to config' do
      File.open("#{SPEC_DIR}/ninjs.conf", "w+") do |file|
        file << File.open("#{SPEC_DIR}/fixtures/updated.ninjs.conf").readlines.join("")
      end
      
      @config.read
      @config.asset_root.should == File.expand_path(SPEC_DIR)
    end
  end # New config

end