class Contents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :name
      t.text :rawhtml
      t.text :xml

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
