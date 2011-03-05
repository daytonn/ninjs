module Ninjs
  def version
    '0.10.1'
  end
  
  def base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
  
  def lib_directory
    File.expand_path(File.join(File.dirname(__FILE__)))
  end
  
  def root_directory
    Dir.getwd
  end
  
  def repository_root
    base_directory + '/repository/'
  end
  
  module_function :version,
                  :base_directory,
                  :lib_directory,
                  :root_directory,
                  :repository_root
end

%w(dependencies configuration helpers manifest project command).each do |lib|
  require "#{Ninjs.lib_directory}/ninjs/#{lib}"
end