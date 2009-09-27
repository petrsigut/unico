class PcfilmtydneController < ApplicationController
  require 'hpricot'
  # na otvirani urlek
  require 'open-uri'

  def index
    # tady tahaji z imdb:
    # http://www.weheartcode.com/2007/04/03/scraping-imdb-with-ruby-and-hpricot/
    
    # film tydne ve Spalicku
    @doc = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1&cin=411&td=2008-09-21&id=0&uid=7c18c3c1b38f4081e601bf2d5eb63b73"))
    #doc = doc.to_s()
    #@movies = @doc.at("//table/#kurzy_tisk").xpath
    @movies = @doc.search("//div[@class='frame red']")

    @movies = @movies.to_s()

    # @movies.gsub!(/[\n\r]/, "")
    # /m nam zajisti ze neresi newlines
    # http://www.regular-expressions.info/ruby.html
#    @movies.gsub!(/(.)*<!-- Begin kurzak CNB -->/m, "")   #=> "sa st"
 #   @movies.gsub!(/<!-- End kurzak CNB -->(.)*/m, "")   #=> "sa st"
#    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    @movies = Hpricot(@movies)

    

  end
end
