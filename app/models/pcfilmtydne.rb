# a tohle zdedime z nejake nadrtidy abychom meli obecne funkce show_txt a
# check_if_old?
class Pcfilmtydne < Content
   attr_accessor :name

  def self.parse_content
    @rawhtml = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1"))
    @rawhtml = @rawhtml.at("//div[@class='frame red']")

    @label1 = @rawhtml.at("//h3")
    @label2 = @rawhtml.at("//h2")
    @image1 = @rawhtml.at("//img")
    @image1 = @image1.attributes['src']
    @label3 = @rawhtml.at("//p")

    create_xml_head
    create_xml_body("label", @label1)
    create_xml_body("label", @label2)
    create_xml_body("image", @image1)
    create_xml_body("label", @label3)
    create_xml_body("label", self.name)

    save_me
    
  end

  
end
