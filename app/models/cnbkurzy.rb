class Cnbkurzy < Content
   attr_accessor :name

  def self.parse_content
    @rawhtml = Hpricot(open("http://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.jsp"))
    @rawhtml = @rawhtml.at("//table[@class='kurzy_tisk']")

    save_me
  end


end
