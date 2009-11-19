class Csfddokin < Content

  def self.parse_content(query = {})
    content = Csfddokin.new
    content.name_human = "ČSFD do kin"
    
    rawhtml = Hpricot(open("http://www.csfd.cz/"))
    rawhtml = rawhtml.search("//body")
    rawhtml = rawhtml.to_s()
    
    rawhtml.gsub!(/(.)*Filmové novinky v kinech/m, "")   #=> "sa st"
    rawhtml.gsub!(/Tento měsíc vychází na DVD(.)*/m, "")   #=> "sa st"
    rawhtml.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    
    rawhtml = Hpricot(rawhtml)
    rawhtml = rawhtml.at("//table")

    content.rawhtml = rawhtml.to_s
    

#    @movies = '<link rel="stylesheet" type="text/css" href="http://localhost/~phax/test.css" />' + @movies


    #logger.fatal "what returns save_me?"
    content = content.save_me(query)
    logger.fatal "content.name"
    logger.fatal content.name
    content


  end


  
end

