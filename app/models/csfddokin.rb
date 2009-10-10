# a tohle zdedime z nejake nadrtidy abychom meli obecne funkce show_txt a
# check_if_old?
class Csfddokin < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open("http://www.csfd.cz/"))
    @movies = @doc.search("//body")
    @movies = @movies.to_s()
    
    @movies.gsub!(/(.)*Filmové novinky v kinech/m, "")   #=> "sa st"
    @movies.gsub!(/Tento měsíc vychází na DVD(.)*/m, "")   #=> "sa st"
    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"

    @movies = '<link rel="stylesheet" type="text/css" href="http://localhost/~phax/test.css" />' + @movies

    @doc = @movies

    save_me
  end

  def self.parse_xml
    save_me
  end

  
end
