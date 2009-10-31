class AddNameHumanToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :name_human, :string
  end

  def self.down
    remove_column :contents, :name_human
  end
end
