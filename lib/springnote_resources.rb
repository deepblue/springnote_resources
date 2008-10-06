$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'oauth'
require 'oauth/consumer'

unless defined?(ActiveResource)
  begin
    $:.unshift(File.dirname(__FILE__) + "/../vendor/activeresource/lib")
    require 'active_resource'  
  rescue LoadError
    require 'activeresource'
  end
end

# extend activeresource
require 'exts/common_parameters'
require 'exts/request_with_oauth'
require 'exts/active_resource_extension'

# Springnote's resources
require 'springnote/configuration'
require 'springnote/base'
require 'springnote/import_file'

require 'springnote/attachment'
require 'springnote/lock'
require 'springnote/revision'
require 'springnote/comment'
require 'springnote/page'

ActiveResource::Connection.oauth_configuration = Springnote::Base.configuration