class CnbController < ApplicationController
  require 'hpricot'
  # na otvirani urlek
  require 'open-uri'

  def index
    # tady tahaji z imdb:
    # http://www.weheartcode.com/2007/04/03/scraping-imdb-with-ruby-and-hpricot/
    
    @doc = Hpricot(open("http://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.jsp"))
    @doc = @doc.search("//table[@class='kurzy_tisk']")

    @doc = @doc.to_s()

    
    # @movies.gsub!(/[\n\r]/, "")
    # /m nam zajisti ze neresi newlines
    # http://www.regular-expressions.info/ruby.html
#    @movies.gsub!(/(.)*<!-- Begin kurzak CNB -->/m, "")   #=> "sa st"
 #   @movies.gsub!(/<!-- End kurzak CNB -->(.)*/m, "")   #=> "sa st"
#    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
 #   @movies = Hpricot(@movies)
    
    #@kurzy = {}
#    (@movies/"//table//tr").each do |row|
#      (row/"//td").each do |cell|
#        logger.fatal cell.inner_html
#      end
#        logger.fatal "XXX"
#    end


  end
end
