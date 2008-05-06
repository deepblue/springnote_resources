module RequestWithOauth
  def self.included(mod)
    mod.alias_method_chain :request, :oauth
    mod.send :cattr_accessor, :oauth_configuration
  end
  
  delegate :oauth_configuration, :to => "self.class"
    
  def request_with_oauth(method, path, *arguments)
    logger.info "#{method.to_s.upcase} #{site.scheme}://#{site.host}:#{site.port}#{path}" if logger
    result = nil
    time = Benchmark.realtime { result = http_request(method, path, arguments) }
    logger.info "--> #{result.code} #{result.message} (#{result.body ? result.body : 0}b %.2fs)" % time if logger
    handle_response(result)
  end
  
  def http_request(method, path, arguments)
    # old way
    return http.send(method, path, *arguments) unless oauth?
    
    # new way
    logger.debug "(request with oauth)" if logger
    @http = http
    req = "Net::HTTP::#{method.to_s.capitalize}".constantize.new(path, *arguments)
    req.oauth! @http, oauth_configuration.consumer, oauth_configuration.token, :signature_method => 'HMAC-SHA1'
      
    @http.request(req)
  end
  
  def oauth?
    oauth_configuration && oauth_configuration.consumer && oauth_configuration.token
  end
end

ActiveResource::Connection.send :include, RequestWithOauth
