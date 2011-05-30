module Ninjs
  module Helpers
    
    def get_filename(module_path)
      module_path = module_path.split(/[\\\/]/).last
      split = module_path.split(/[\.\-\s]/)
      module_filename = String.new
      split.each do |piece|
        module_filename << piece unless piece.match(/^module$|^js$/i)
      end
      module_filename
    end
    
    module_function :get_filename
    
  end
end