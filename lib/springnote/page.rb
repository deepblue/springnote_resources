require 'active_resource_extension'

class Springnote::Page < Springnote::Base
  extend ActiveResourceExtension
  
  def self.with_tags(tags, params = {})
    find(:all, :params => prarams.reverse_merge(:tags => tags))
  end

  def self.search(query, params = {})
    find(:all, :params => params.reverse_merge(:q => query))
  end
  
  def lock
    @lock ||= Lock.find(:relation_is_part_of => self.id)
  end

  def attachments
    @attachments ||= Attachment.find(:all, :params => {:relation_is_part_of => self.id})
  end
end
