class CreateImageTags < ActiveRecord::Migration
  def self.up
    create_table :image_tags do |t|
      t.string :image_tag

      t.timestamps
    end
  end

  def self.down
    drop_table :image_tags
  end
end
