require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :redmine_wiki_publisher do
    unless ProjectsHelper.included_modules.include?(ProjectTabsExtended)
        ProjectsHelper.send(:include, ProjectTabsExtended)
    end
end

Redmine::Plugin.register :wiki_publisher_redmine do
  name 'Plugin Wiki Publisher'
  author 'Daniel Camargo / Heverson Vasconcelos / Rodrigo Kuninari'
  description 'This is a plugin for Redmine that publishes project documentation into wiki'
  version '0.0.9'
  url "https://github.com/heversonvasconcelos/wiki_publisher_redmine"

  requires_redmine :version_or_higher => '1.3.0'

end
