class AddImageurlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :imageurl, :string
  end

  def self.down
    remove_column :photos, :imageurl
  end
end
