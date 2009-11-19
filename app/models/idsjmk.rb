class Idsjmk < Content

  def self.parse_content(query = {})
    content = Idsjmk.new
    content.name_human = "IDS JMK odjezdy"
    
    if (query["stopId"].nil? or query["poleId"].nil?)
      url = "http://wap.aspone.cz/GetDepartures.ashx?stopId=1166&poleId=1"
    else
      url = "http://wap.aspone.cz/GetDepartures.ashx?stopId=#{query["stopId"]}&poleId=#{query["poleId"]}"
    end


    rawhtml = Hpricot(open(url))
    content.rawhtml = rawhtml.to_s

    content.save_me(query)
  end

end
