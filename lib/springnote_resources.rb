$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(ActiveResource)
  begin
    $:.unshift(File.dirname(__FILE__) + "/../vendor/activeresource/lib")
    require 'active_resource'  
  rescue LoadError
    require 'rubygems'
    require 'activeresource'
  end
end

# extend activeresource
require 'exts/common_parameters'
require 'exts/active_resource_extension'

# Springnote's resources
require 'springnote/configuration'
require 'springnote/base'
require 'springnote/import_file'

require 'springnote/page'
require 'springnote/attachment'
require 'springnote/lock'
require 'springnote/revision'
