require "spec_helper"

describe Ninjs::Manifest do
  it 'should conatin the correct driectories' do
    directories = %w(application elements lib models modules plugins tests tests/qunit)
    Ninjs::Manifest.directories.should === directories
  end
end