class Googlepocasibrno < Content
  require 'rexml/document'

   attr_accessor :name

  def self.parse_content
    url="http://www.google.com/ig/api?weather=#{@query},czech+republic&hl=en"
    url="http://www.google.com/ig/api?weather=brno,czech+republic&hl=en"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    create_xml_head

    doc.elements.each("xml_api_reply/weather/current_conditions/*") do |element|
      create_xml_body("label", element.attributes.get_attribute("data"))
    end


    save_me
  end


end
