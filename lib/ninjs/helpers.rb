module Ninjs
  module Helpers
    
    def create_module_filename(module_name)
      module_name = module_name.split(/[\\\/]/).last
      split = module_name.split(/[\.\-\s]/)
      module_filename = String.new
      split.each do |piece|
        module_filename << piece unless piece.match(/^module$|^js$/i)
      end
      module_filename
    end
    
    module_function :create_module_filename
    
  end
end