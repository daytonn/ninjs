require "spec_helper"

describe Ninjs::Helpers do
  it 'should create a module filename from a POSIX path' do
    Ninjs::Helpers.create_module_filename('/some/path/some.module.js').should === 'some'
  end
  
  it 'should create a module filename from a Windows path' do
    Ninjs::Helpers.create_module_filename('D:\\\\some\path\some.module.js').should === 'some'
  end
end