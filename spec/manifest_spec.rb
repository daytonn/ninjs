require "spec_helper"

describe Ninjs::Manifest do
  it 'should conatin the correct driectories' do
    directories = %w(application elements lib models modules plugins spec spec/javascripts spec/javascripts/support)
    Ninjs::Manifest.directories.should === directories
  end
end