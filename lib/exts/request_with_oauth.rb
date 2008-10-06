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

    req = create_http_request(method, path, *arguments)
    req.oauth! @http, oauth_configuration.consumer, oauth_configuration.token, :signature_method => 'HMAC-SHA1', :clobber_request => true
    # logger.debug req.to_hash

    @http.request(req)
  end
  
  def oauth?
    oauth_configuration && oauth_configuration.consumer && oauth_configuration.token
  end
  
protected
  # code from ruby-oauth
  # create the http request object for a given http_method and path
  def create_http_request(http_method,path,*arguments)
    http_method=http_method.to_sym
    if [:post,:put].include?(http_method)
      data=arguments.shift
    end
    headers=(arguments.first.is_a?(Hash) ? arguments.shift : {})
    case http_method
    when :post
      request=Net::HTTP::Post.new(path,headers)
      request["Content-Length"]=0 # Default to 0
    when :put
      request=Net::HTTP::Put.new(path,headers)
      request["Content-Length"]=0 # Default to 0
    when :get
      request=Net::HTTP::Get.new(path,headers)
    when :delete
      request=Net::HTTP::Delete.new(path,headers)
    when :head
      request=Net::HTTP::Head.new(path,headers)
    else
      raise ArgumentError, "Don't know how to handle http_method: :#{http_method.to_s}"
    end
    if data.is_a?(Hash)
      request.set_form_data(data)
    elsif data
      request.body=data.to_s
      request["Content-Length"]=request.body.length
    end
    request
  end  
end

ActiveResource::Connection.send :include, RequestWithOauth
