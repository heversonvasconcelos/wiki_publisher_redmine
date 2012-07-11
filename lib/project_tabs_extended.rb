require_dependency 'projects_helper'

module ProjectTabsExtended
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :project_settings_tabs, :wiki_publisher
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def project_settings_tabs_with_wiki_publisher
      tabs = project_settings_tabs_without_wiki_publisher
      tabs.push({:name => :wiki_publisher, :partial => 'projects/settings/wiki_publisher', :label => :wiki_publisher})
      return tabs
    end

  end

end
