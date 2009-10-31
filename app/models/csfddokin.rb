# a tohle zdedime z nejake nadrtidy abychom meli obecne funkce show_txt a
# check_if_old?
class Csfddokin < Content

  def self.parse_content
    @name_human = "ČSFD do kin"
    
    @rawhtml = Hpricot(open("http://www.csfd.cz/"))
    @rawhtml = @rawhtml.search("//body")
    @rawhtml = @rawhtml.to_s()
    
    @rawhtml.gsub!(/(.)*Filmové novinky v kinech/m, "")   #=> "sa st"
    @rawhtml.gsub!(/Tento měsíc vychází na DVD(.)*/m, "")   #=> "sa st"
    @rawhtml.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    
    @rawhtml = Hpricot(@rawhtml)
    @rawhtml = @rawhtml.at("//table")

#    @movies = '<link rel="stylesheet" type="text/css" href="http://localhost/~phax/test.css" />' + @movies


    save_me
  end

  
end
