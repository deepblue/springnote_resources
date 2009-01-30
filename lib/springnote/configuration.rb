require 'cgi'

module Springnote
  class MissingConfiguration < RuntimeError; end
  
  class Configuration
    attr_accessor :consumer_token, :consumer_secret
    attr_accessor :access_token,   :access_secret
    attr_accessor :protocol, :domain
    
    def server_url
      if server_port != 80
        [server_host, server_port].join(":")
      else
        server_host
      end
    end
    
    def server_host=(host)
      @server_host = host
    end
    
    def server_host
      @server_host
    end
    
    def server_port=(port)
      @server_port = port
    end
    
    def server_port
      @server_port || 80
    end
    
    def protocol
      @protocol || 'http'
    end    
    
    def load(file)
      set YAML.load(File.read(file))
    end
            
    def set(options = {})
      #reset
      @token = nil
      @consumer = nil

      options.each{|k,v| self.send("#{k}=", v)}
      Springnote::Base.site = self.site
      if @app_key && Springnote::Base.respond_to?(:user=)
        Springnote::Base.user = self.username
        Springnote::Base.password = self.password
      end
      self
    end
        
    def domain=(name = nil)
      ActiveResource::Connection.common_params[:domain] = name
    end
    
    def site
      @app_key ? 
        "#{protocol}://#{username}:#{password}@#{server_url}/" :
        "#{protocol}://#{server_url}/"
    end
    
    def token
      @token ||= OAuth::AccessToken.new consumer, @access_token, @access_secret if @access_token && @access_secret
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
