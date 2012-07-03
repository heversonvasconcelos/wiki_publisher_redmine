

class WikiPublisherSetting < ActiveRecord::Base
   unloadable
   belongs_to :wikis
	
   validates_presence_of :wiki_id, :design_repository_url

   def self.find_or_create(wiki_id)
      wiki_publisher_setting = WikiPublisherSetting.find(:first, :conditions => ['wiki_id = ?', wiki_id])
      unless setting
         wiki_publisher_setting = WikiPublisherSetting.new
         wiki_publisher_setting.wiki_id = wiki_id
         wiki_publisher_setting.save!      
      end

     return wiki_publisher_setting
  end

	
end
