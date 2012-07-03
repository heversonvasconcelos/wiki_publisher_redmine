require 'redmine'

Redmine::Plugin.register :redmine_wiki_publisher do
  name 'Redmine Wiki Publisher plugin'
  author 'Heverson Vasconcelos'
  description 'This is a plugin for Redmine that publishes project documentation into wiki'
  version '0.0.1'
  
  #Menu Configuration
  menu :project_menu, :wiki_publisher, { :controller => 'wiki_publisher', :action => 'index' }, :caption => 'Wiki Publisher', :before => :settings, :param => :project_id

end
