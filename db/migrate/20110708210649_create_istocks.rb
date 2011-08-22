class CreateIstocks < ActiveRecord::Migration
  def self.up
    create_table :istocks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :istocks
  end
end
