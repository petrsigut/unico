class AddHtmlFromXmlToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :xhtml, :text
  end

  def self.down
    remove_column :contents, :xhtml
  end
end
