class Pcfilmtydne < Content

  def self.parse_content(query = {})
    content = Pcfilmtydne.new
    content.name_human = "Palace Cinemas: Film týdne"

    rawhtml = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1"))
    rawhtml = rawhtml.at("//div[@class='frame red']")

    label1 = rawhtml.at("//h3")
    label2 = rawhtml.at("//h2")
    image1 = rawhtml.at("//img")
    image1 = image1.attributes['src']
    label3 = rawhtml.at("//p").inner_text

    content.create_xml_head
    content.create_xml_body("label", label1)
    content.create_xml_body("label", label2)
    content.create_xml_body("image", image1)
    content.create_xml_body("label", label3)

    content.rawhtml = rawhtml.to_s

    # fix the UID - it changes everytime...
    content.save_me(query)
    
  end

  
end
