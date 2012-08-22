require File.dirname(__FILE__) + '/../test_helper'
require 'tmpdir'
require 'find'

class WikiPublisherControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  #self.use_instantiated_fixtures = true
  #fixtures :projects, :repositories
  def setup
    @project = Project.find(1)
    @wiki = @project.wiki
    @repo = @project.repository
    @design_repository_url = 'trunk/design'
    @text_formatting = Setting.text_formatting
  end

  def test_project_find
    assert_equal(@project.identifier, 'projetoteste')
  #assert_equal(@project.identifier, 'redminewikipublisher')
  end

  def test_wiki_format
    #logger.info('.' + @text_formatting)
    assert_equal(@text_formatting, 'textile')
  end

  def test_repository_find
    assert_not_nil(@repo)
    logger.info(@repo.url)
    logger.info(@repo.login)
    logger.info(@repo.password)
  end

  def test_project_repository_find_textile_files
    Dir.chdir(Dir.tmpdir)
    `svn co #{@repo.url} --username #{@repo.login} --password #{@repo.password} --no-auth-cache --non-interactive`
    Dir.chdir(@project.identifier)
    design_files = File.join(@design_repository_url, "**", "*." + @text_formatting)
    repo_files = Dir.glob(design_files)
    assert_not_nil(repo_files)
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
