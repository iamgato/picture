class RemoveTagFromPhoto < ActiveRecord::Migration
  def self.up
    remove_column :photos, :tag
  end

  def self.down
    add_column :photos, :tag, :string
  end
end
