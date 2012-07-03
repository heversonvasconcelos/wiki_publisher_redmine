
class CreateWikiPublisherSettings < ActiveRecord::Migration
  def self.up
    create_table :wiki_publisher_settings do |t|

      t.column :wiki_id, :integer
      t.string :design_repository_url, :limit => 60, :default => 'trunk/design'

    end
  end

  def self.down
    drop_table :wiki_publisher_settings
  end
end
