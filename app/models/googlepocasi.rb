class Googlepocasi < Content

  def self.parse_content(query = {})

    content = Googlepocasi.new
    content.name_human = "Google počasí"

    if query["city"].nil?
      url="http://www.google.com/ig/api?weather=brno,czech+republic&hl=en"
    else
      url="http://www.google.com/ig/api?weather=#{query["city"]},czech+republic&hl=en"
    end
    
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    content.create_xml_head
    content.create_xml_body("label", query["city"])

    url_base = "http://www.google.com"

    doc.elements.each("xml_api_reply/weather/current_conditions/*") do |element|
#     element_data = (element.text)
      logger.fatal "Element:"
      element.attributes.each do |name, value|
      
        element_data = value
        extension = element_data.split('.').last
        if (extension == "gif")
          element_data = url_base + element_data
          element_name = "image"
        else
          element_name = "label"
        end
         
        content.create_xml_body(element_name, element_data)
      end
    end


    content.save_me(query)
    
  end


end
