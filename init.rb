require 'redmine'
require 'dispatcher'
  
Dispatcher.to_prepare :redmine_wiki_publisher do
    unless ProjectsHelper.included_modules.include?(ProjectTabsExtended)
        ProjectsHelper.send(:include, ProjectTabsExtended)
    end
end

Redmine::Plugin.register :redmine_wiki_publisher do
  name 'Redmine Wiki Publisher plugin'
  author 'Heverson Vasconcelos'
  description 'This is a plugin for Redmine that publishes project documentation into wiki'
  version '0.0.1'

end
