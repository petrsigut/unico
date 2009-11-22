class Fiterminy < Content

  def self.parse_content(query = {})
    content = Fiterminy.new
    content.name_human = "FI MUNI: aktuální termíny"
    
    rawhtml = Hpricot(open("http://www.fi.muni.cz/studies/dates.xhtml"))

    rawhtml = rawhtml.search("//table")
    logger.fatal rawhtml.inspect

    if (query["mgr"] == "yes")
      content.rawhtml = rawhtml.second.to_s
    else
      content.rawhtml = rawhtml.first.to_s
    end

    content.save_me(query)
  end

end
