class Fiterminy < Content

  def self.parse_content(query = {})
    content = Fiterminy.new
    content.name_human = "FI MUNI: aktuální termíny"
    
    rawhtml = Hpricot(open("http://www.fi.muni.cz/studies/dates.xhtml"))
    rawhtml = rawhtml.at("//table")

    content.rawhtml = rawhtml.to_s

    content.save_me(query)
  end

end
