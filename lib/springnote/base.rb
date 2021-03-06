module Springnote
  VERSION = "0.6.6"
  
  class Base < ActiveResource::Base
    extend ActiveResourceExtension
    
    set_primary_key 'identifier'
    
    def id
      attributes["identifier"]
    end

    def id=(id)
      attributes["identifier"] = id
    end
    
    def to_param
      identifier.to_s
    end
    
    class <<self
      attr_accessor_with_default :configuration, Springnote::Configuration.new
    end    
  end # Base
end # module Springnote
