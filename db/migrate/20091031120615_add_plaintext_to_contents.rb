class AddPlaintextToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :plaintext, :text
  end

  def self.down
    remove_column :contents, :plaintext
  end
end
