class Cnbkurzy < Content

  def self.parse_content(query = {})
    content = Cnbkurzy.new
    content.name_human = "Kurzy ČNB"
    
    rawhtml = Hpricot(open("http://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.jsp"))
    rawhtml = rawhtml.at("//table[@class='kurzy_tisk']")

    content.rawhtml = rawhtml.to_s

    content.save_me(query)
  end



end
