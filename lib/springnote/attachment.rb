module Springnote
  class Attachment < Base
    set_prefix      '/pages/:relation_is_part_of/'
    
    def source
      http = Net::HTTP.new(Springnote::Configuration::SERVER_URL, 80)
      req = Net::HTTP::Get.new(element_path[0..-5])
      req.basic_auth(Springnote::Base.site.user, Springnote::Base.site.password)
      response = http.request(req)
      response.body
    end
  end
end # module Springnote
