module Ninjs
  module Manifest
    def directories
      %w(application elements lib models modules plugins spec spec/javascripts spec/javascripts/support)
    end
    
    module_function :directories
  end
end