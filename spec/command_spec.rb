require "spec_helper"

describe Ninjs::Command do  
  
  it 'should have a watch method' do
    Ninjs::Command.watch.should_not be_nil
  end
  
end