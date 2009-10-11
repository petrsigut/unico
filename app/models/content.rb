class Content < ActiveRecord::Base
  require 'hpricot'
  require 'open-uri'
  require 'net/http'
  require "rexml/document"
  
  # private nebo tak neco?
  def self.create_xml_head
    @xml = REXML::Document.new
    @kml = @xml.add_element 'kml', {'xmlns' => 'http://kml.ns.cz'}
    @kml_doc = @kml.add_element 'document'
  end

  def self.create_xml_body(entity_name, entity_text)
    (@kml_doc.add_element entity_name).text = entity_text
    #(@kml_doc.add_element 'video').text = "http://tinyvid.tv/vfe/big_buck_bunny.mp4"
  end

  def self.create_gallery(array_of_links)
    html_chunk = '<div id="slideshow">'
    html_chunk += "<img src=\"#{array_of_links[0]}\" alt=\"Slideshow Image 1\" class=\"active\" />\n"
    array_of_links.each_with_index do |link, index|
      html_chunk += "<img src=\"#{array_of_links[index]}\" alt=\"Slideshow Image 1\" />\n"
    end

    html_chunk += '</div>'

  end

  def self.save_me
    # tohle až do konce můžu zoobecnit pro všechny třídy...
    @content = Content.find_by_name(self.name) # udelat pres tridni promenou?
    
    if @content.nil?
      @content = Content.new
    end
    
    @content.name = self.name
    @content.xml = @kml_doc.to_s
    @content.rawhtml = @doc.to_s
    @content.save


  end


 
end
