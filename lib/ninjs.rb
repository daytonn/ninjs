module Ninjs
  VERSION = '0.11.0'
  BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  LIB_DIR = File.expand_path(File.join(File.dirname(__FILE__)))
  ROOT_DIR = Dir.getwd
end

%w(dependencies configuration helpers manifest project command notification).each do |lib|
  require "#{Ninjs::LIB_DIR}/ninjs/#{lib}"
end