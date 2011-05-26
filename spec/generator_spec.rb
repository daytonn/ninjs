require "spec_helper"

describe Ninjs::Generator do
  before :each do
    @config = {
      :project => Ninjs::Project.new('myapp'),
      :type => 'module',
      :name => 'mymod',
      :alias => nil,
      :dest => 'application',
      :src => 'modules',
      :dependencies => { :elements => false, :model => false }
    }
    
    @test_dirs = %w(application modules elements models)
    @test_dirs.each do |dir|
      FileUtils.mkdir(dir)
    end
    
  end
  
  after :each do
    #FileUtils.rm('modules/mymod.module.js')
    #@test_dirs.each do |dir|
    #  FileUtils.rmdir(dir)
    #end
  end
  
  it 'should should generate a module file' do
    generator = Ninjs::Generator.new(@config)
    #generator.project.proj
    generator.generate
  end
end