module Springnote
  class Attachment < Base
    set_prefix      '/pages/:relation_is_part_of/'
    
    def source
      http = Net::HTTP.new(Springnote::Configuration::SERVER_URL, Springnote::Configuration::SERVER_PORT)
      req = Net::HTTP::Get.new(element_path[0..(element_path.rindex('.xml') -1)])
      req.basic_auth(Springnote::Base.site.user, Springnote::Base.site.password)
      response = http.request(req)
      response.body
    end
  end
end # module Springnote
