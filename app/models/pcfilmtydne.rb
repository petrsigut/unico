# a tohle zdedime z nejake nadrtidy abychom meli obecne funkce show_txt a
# check_if_old?
class Pcfilmtydne < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1"))
    @doc = @doc.search("//div[@class='frame red']")
    save_me
  end

  def self.parse_xml
    @doc = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1"))
    @doc = @doc.search("//div[@class='frame red']")

    @label1 = @doc.at("//h3")
    @label2 = @doc.at("//h2")
    @image1 = @doc.at("//img")
    @image1 = @image1.attributes['src']
    @label3 = @doc.at("//p")

    create_xml_head
    create_xml_body("label", @label1)
    create_xml_body("label", @label2)
    create_xml_body("image", @image1)
    create_xml_body("label", @label3)
    create_xml_body("label", self.name)

    save_me
    
  end

  
end
