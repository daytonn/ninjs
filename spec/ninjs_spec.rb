require "spec_helper"

describe Ninjs do  
  it 'should have the correct BASE_DIR' do
    Ninjs::BASE_DIR.should == File.expand_path('../')
  end
  
  it 'should have the correct LIB_DIR' do
    Ninjs::LIB_DIR.should === File.expand_path('../lib')
  end
  
  it 'should have the correct ROOT_DIR' do
    Ninjs::ROOT_DIR.should === File.expand_path(Dir.getwd)
  end
  
  it 'should have the correct VERSION' do
    version = File.open("#{Ninjs::BASE_DIR}/VERSION").readlines.join('')
    Ninjs::VERSION.should === version
  end
end