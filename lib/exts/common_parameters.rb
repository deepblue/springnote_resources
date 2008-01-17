module CommonParameters
  def self.included(mod)
    mod.alias_method_chain :request, :commons
    mod.send :cattr_accessor, :common_params
    mod.common_params = {}
  end
    
  def request_with_commons(method, path, *arguments)
    unless common_params.empty?
      path += path.include?('?') ? '&' : '?'
      path += common_params.to_query
    end
    request_without_commons(method, path, *arguments)
  end
  
  def common_params
    self.class.common_params
  end  
end

ActiveResource::Connection.send :include, CommonParameters
