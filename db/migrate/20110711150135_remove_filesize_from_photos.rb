class RemoveFilesizeFromPhotos < ActiveRecord::Migration
  def self.up
    remove_column :photos, :filesize
    remove_column :photos, :filetype
    remove_column :photos, :description
    remove_column :photos, :imageurl
  end

  def self.down
    add_column :photos, :imageurl, :string
    add_column :photos, :description, :string
    add_column :photos, :filetype, :string
    add_column :photos, :filesize, :string
  end
end
