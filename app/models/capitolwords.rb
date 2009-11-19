class Capitolwords < Content

  def self.parse_content(query = {})
    content = Capitolwords.new
    content.name_human = "Top capitol words today"

    if query["number"].nil?
      url = "http://capitolwords.org/api/wod/latest/top10.xml"
    else    
      url = "http://capitolwords.org/api/wod/latest/top#{query["number"]}.xml"
    end

    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)
    
    content.create_xml_head
    doc.elements.each("xml/wordsofday/*") do |element|
      word = element.attributes.get_attribute("word").value
      word_count = element.attributes.get_attribute("word_count").value
      content.create_xml_body("label", word+" "+word_count)
    end



    content.save_me(query)
  end

end
