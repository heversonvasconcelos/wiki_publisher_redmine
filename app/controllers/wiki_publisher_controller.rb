require 'tmpdir'
require 'find'

class WikiPublisherController < ApplicationController
   before_filter :find_wiki, :find_repository

   def import_wiki_files_from_repository
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
   end
  
   def find_repository_wiki_files
      Dir.chdir(Dir.tmpdir)
      `svn co #{@repo.url}`
      Dir.chdir(@project.identifier)
      design_files = File.join(@design_repository_url, "**", "*." + @text_formatting)
      repo_files = Dir.glob(design_files)
      return repo_files
   end

end

