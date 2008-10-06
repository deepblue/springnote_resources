class Springnote::Page < Springnote::Base
  include Springnote::ImportFile
  
  def self.with_tags(tags, params = {})
    find(:all, :params => params.reverse_merge(:tags => tags))
  end

  def self.search(query, params = {})
    find(:all, :params => params.reverse_merge(:q => query))
  end
  
  def lock
    @lock ||= Springnote::Lock.find(:relation_is_part_of => self.id)
  end

  def attachments
    @attachments ||= Springnote::Attachment.find(:all, :params => {:relation_is_part_of => self.id})
  end
  
  def comments
    @comments ||= Springnote::Comment.find(:all, :params => {:relation_is_part_of => self.id})
  end
end
