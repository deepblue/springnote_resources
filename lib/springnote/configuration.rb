require 'cgi'

module Springnote
  class MissingConfiguration < RuntimeError; end
  
  class Configuration
    attr_accessor :consumer_token, :consumer_secret
    attr_accessor :access_token,   :access_secret
    attr_accessor :protocol, :domain
    
    SERVER_URL = "api.springnote.com"
    
    def protocol
      @protocol || 'http'
    end    
    
    def load(file)
      set YAML.load(File.read(file))
    end
        
    def set(options = {})
      options.each{|k,v| self.send("#{k}=", v)}
      Springnote::Base.site = self.site
      self
    end
        
    def domain=(name = nil)
      ActiveResource::Connection.common_params[:domain] = name
    end
    
    def site
      @app_key ? 
        "#{protocol}://#{username}:#{password}@#{SERVER_URL}/" :
        "#{protocol}://#{SERVER_URL}/"
    end
    
    def token
      @token ||= OAuth::Token.new @access_token, @access_secret if @access_token && @access_secret
    end
    
    def consumer
      @consumer ||= OAuth::Consumer.new @consumer_token, @consumer_secret, :site => "https://api.openmaru.com" if @consumer_token && @consumer_secret
    end

    # deprecated
    attr_writer   :app_key, :user_key
    attr_writer   :user_openid
    
    def username
      CGI.escape(@user_openid || 'anonymous')
    end
        
    def password
      @user_key ? [@user_key, app_key].join('.') : app_key
    end
    
    def app_key
      @app_key
    end    
  end
end # module Springnote
