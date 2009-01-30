class Springnote::Attachment < Springnote::Base
  set_prefix '/pages/:relation_is_part_of/'
  include Springnote::ImportFile
    
  def source
    http = Net::HTTP.new(Springnote::Configuration::server_host, Springnote::Configuration::server_port)
    req = Net::HTTP::Get.new(element_path[0..-5])
    req.basic_auth(Springnote::Base.site.user, Springnote::Base.site.password)
    response = http.request(req)
    response.body
  end
end
