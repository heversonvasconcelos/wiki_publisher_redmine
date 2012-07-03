require File.dirname(__FILE__) + '/../test_helper'
require 'tmpdir'
require 'find'

class WikiPublisherControllerTest < ActionController::TestCase
  fixtures :projects, :repositories
  self.use_transactional_fixtures = false

  def setup
     @project = Project.find(1)
     @wiki = @project.wiki
     @repo = @project.repository
     @designrepodir = 'trunk/design'
     @text_formatting = Setting.text_formatting
  end

  def test_project_find
    assert_equal(@project.identifier, 'projetoteste')
  end

  def test_wiki_format
    logger.info('.' + @text_formatting)
    assert_equal(@text_formatting, 'textile')
  end

  def test_project_repository_find_textile_files
    Dir.chdir(Dir.tmpdir)
    `svn co #{@repo.url}`
    Dir.chdir(@project.identifier)
    textile_design_files = File.join(@designrepodir, "**", "*.textile")
    repo_files = Dir.glob(textile_design_files)
    return repo_files
  end

=begin
  def test_project_create_wiki_page
    files = test_project_repository_find_textile_files
    files.each do |file|
       pagetitle = File.basename(file, ".textile")
       @page = @wiki.find_or_new_page(pagetitle)
       if(@page != nil)
          @page.content = WikiContent.new(:page => @page)
          @page.content.text = "{{repo_include(#{file})}}"
          @page.save
       end
    end
  end
=end
end
