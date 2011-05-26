module Ninjs
  BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  LIB_DIR = File.expand_path(File.join(File.dirname(__FILE__)))
  ROOT_DIR = Dir.getwd
  VERSION = File.open("#{BASE_DIR}/pkg/VERSION").readlines.join("")
end

%w(dependencies configuration helpers manifest project notification generator command).each do |lib|
  require "#{Ninjs::LIB_DIR}/ninjs/#{lib}"
end