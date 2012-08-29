require 'tmpdir'
require 'find'

class WikiPublisherController < ApplicationController
  before_filter :find_wiki
  def import_wiki_files_from_repository
    begin
      files = find_repository_wiki_files
      files.each do |file|
        pagetitle = File.basename(file, '.' + @text_formatting)
        @page = @wiki.find_or_new_page(pagetitle)
        if(@page != nil)
          @page.content = WikiContent.new(:page => @page)
          @page.content.text = "{{repo_include(#{file})}}"
        @page.save
        end
      end
    rescue => e
      flash[:warning] = e.message
    end

    redirect_to :controller => 'wiki', :action => 'show', :project_id => @project
  end

  private

  def find_wiki
    @project = Project.find(params[:project_id])
    @wiki = @project.wiki
    @text_formatting = Setting.text_formatting
  end

  def find_repository
    @repo = @project.repository
    @wiki_publisher_setting = WikiPublisherSetting.find(:first, :conditions => ['wiki_id = ?', @wiki.id])
    @design_repository_url = @wiki_publisher_setting.design_repository_url

    if(@repo.nil?)
      raise l(:error_failed_to_access_project_repository)
    elsif(@wiki_publisher_setting.nil? || @design_repository_url.nil?)
      raise l(:error_failed_to_access_redmine_wiki_publisher_settings)
    end
  end

  #TODO: Refatorar este metodo para um helper que funcione para os demais SCM
  def find_repository_wiki_files
    begin
      find_repository
      Dir.chdir(Dir.tmpdir)
      `svn co #{@repo.url} --username #{@repo.login} --password #{@repo.password} --no-auth-cache --non-interactive --force`
      Dir.chdir(@project.identifier)
      design_files = File.join(@design_repository_url, "**", "*." + @text_formatting)
      repo_files = Dir.glob(design_files)

      if(repo_files.empty?)
        raise l(:error_repository_wiki_files_not_found)
      end
    rescue => e
      raise e
    end

    return repo_files
  end

end

