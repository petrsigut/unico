class MoviesController < ApplicationController
  require 'hpricot'
  # na otvirani urlek
  require 'open-uri'

  def index
    # tady tahaji z imdb:
    # http://www.weheartcode.com/2007/04/03/scraping-imdb-with-ruby-and-hpricot/
    
    @doc = Hpricot(open("http://www.csfd.cz/"))
    @movies = @doc.search("//body")
    @movies = @movies.to_s()

    
    # @movies.gsub!(/[\n\r]/, "")
    # /m nam zajisti ze neresi newlines
    # http://www.regular-expressions.info/ruby.html
    @movies.gsub!(/(.)*Filmové novinky v kinech/m, "")   #=> "sa st"
    @movies.gsub!(/Tento měsíc vychází na DVD(.)*/m, "")   #=> "sa st"
    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    @movies = Hpricot(@movies)

  end
end
