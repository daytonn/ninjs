require "spec_helper"

describe Ninjs do
  it 'should have a BASE_DIR constant' do
    Ninjs::BASE_DIR.should_not be_nil
  end
  
  it 'should have the correct BASE_DIR' do
    Ninjs::BASE_DIR.should === '/Volumes/Storage/Development/ninjs'
  end
  
  it 'should have a LIB_DIR constant' do
    Ninjs::LIB_DIR.should_not be_nil
  end
  
  it 'should have the correct LIB_DIR' do
    Ninjs::LIB_DIR.should === '/Volumes/Storage/Development/ninjs/lib'
  end
  
  it 'should have a ROOT_DIR constant' do
    Ninjs::ROOT_DIR.should_not be_nil
  end
  
  it 'should have the correct ROOT_DIR' do
    Ninjs::ROOT_DIR.should === '/Volumes/Storage/Development/ninjs'
  end
  
  it 'should have a VERSION constant' do
    Ninjs::VERSION.should_not be_nil
  end
  
  it 'should have the correct VERSION' do
    version = File.open("#{Ninjs::BASE_DIR}/VERSION").readlines.join('')
    Ninjs::VERSION.should === version
  end
end