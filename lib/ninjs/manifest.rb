module Ninjs
  module Manifest
    def directories
      %w(application elements lib models modules plugins tests tests/qunit)
    end
    
    module_function :directories
  end
end