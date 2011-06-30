require "spec_helper"

describe Ninjs do  
  it 'should have a BASE_DIR constant' do
    Ninjs::BASE_DIR.should_not be_nil
  end
  
  it 'should have a LIB_DIR constant' do
    Ninjs::LIB_DIR.should_not be_nil
  end
  
  it 'should have a ROOT_DIR' do
    Ninjs::ROOT_DIR.should_not be_nil
  end
  
  it 'should have the correct VERSION' do
    version = File.open("#{Ninjs::BASE_DIR}/VERSION").readlines.join('')
    Ninjs::VERSION.should === version
  end
end