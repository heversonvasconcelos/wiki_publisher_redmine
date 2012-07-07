
class CreateWikiPublisherSettings < ActiveRecord::Migration
  def self.up
    create_table :wiki_publisher_settings do |t|

      t.column :wiki_id, :integer
      #Project design directory wich store the documentation. Example: 'trunk/design'
      t.column :design_repository_url, :string, :limit => 255, :default => 'trunk/design', :null => false

    end
  end

  def self.down
    drop_table :wiki_publisher_settings
  end
end
