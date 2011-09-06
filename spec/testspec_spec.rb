require "spec_helper"

describe 'The spec files' do
  it 'should have a SPEC_DIR constant' do
    SPEC_DIR.should == File.expand_path("#{Dir.getwd}/spec")
  end
end