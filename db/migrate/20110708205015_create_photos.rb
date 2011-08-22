class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :filesize
      t.string :tag
      t.string :description
      t.string :filetype

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
