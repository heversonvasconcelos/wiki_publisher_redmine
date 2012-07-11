class WikiPublisherSettingsController < ApplicationController
  unloadable

  menu_item :wiki_publisher
  before_filter :find_project, :find_wiki
  def edit
    design_repository_url = params[:wiki_publisher_setting][:design_repository_url]
    @wiki_publisher_setting = WikiPublisherSetting.find_or_create(@wiki.id)
    @wiki_publisher_setting.design_repository_url = design_repository_url
    @wiki_publisher_setting.save!

    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => :wiki_publisher
  end

  private

  def find_wiki
    #@project = Project.find(params[:project_id])
    @wiki = @project.wiki
  end

end

