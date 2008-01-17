module Springnote
  class Attachment < Base
    set_prefix      '/pages/:relation_is_part_of/'
    def get_raw_data
      springnote_url = URI.parse(self.site)
      http = Net::HTTP.new(springnote_url.host, springnote_url.port)
      req = Net::HTTP::Get.new("/pages/#{relation_is_part_of}/attachments/#{self.id}")
      req.basic_auth(self.site.user, self.site.password)
      response = http.request(req)
      response.body
    end
  end
end # module Springnote
