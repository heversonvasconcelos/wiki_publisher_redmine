

class WikiPublisherSettingsController < ApplicationController
   before_filter :find_wiki

   def update
     design_repository_url = params[:wiki_publisher_setting][:design_repository_url]
     wiki_publisher_setting = WikiPublisherSetting.find_or_create @wiki.id
     begin
        wiki_publisher_setting.transaction do
           wiki_publisher_setting.design_repository_url = design_repository_url
           wiki_publisher_setting.save!
        end
        flash[:notice] = l(:notice_successful_update)
     rescue
      flash[:error] = l(:notice_failed_to_save_redmine_wiki_publisher_settings)
    end
   end
   
private
   def find_wiki
     @project = Project.find(params[:project_id])
     @wiki = @project.wiki
   end

end

