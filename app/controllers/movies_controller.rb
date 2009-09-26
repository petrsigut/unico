class MoviesController < ApplicationController
  require 'hpricot'
  # na otvirani urlek
  require 'open-uri'

  def index
#    doc = Hpricot("<p>A simple <b>tesxxt</b> string.</p>")
    #
    #    tady tahaji z imdb:
    #    http://www.weheartcode.com/2007/04/03/scraping-imdb-with-ruby-and-hpricot/
    #@doc = Hpricot(open("http://www.csfd.cz/"))
    @doc = Hpricot(open("http://localhost/~phax/csfd/"))
    #doc = doc.to_s()
    @movies = @doc.search("//body")
    @movies = @movies.to_s()
    
#    @movies.gsub!(/[\n\r]/, "")
    # /m nam zajisti ze neresi newlines
    # http://www.regular-expressions.info/ruby.html
    @movies.gsub!(/(.)*Filmové novinky v kinech/m, "")   #=> "sa st"
    @movies.gsub!(/Tento měsíc vychází na DVD(.)*/m, "")   #=> "sa st"
    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    @movies = Hpricot(@movies)
    @odkazy = {}
    (@movies/"table//td//a").each do |obj|
      @odkazy[obj.attributes['href']] = obj.inner_text
    end

    @filmik = Movie.new
    @filmik.name = ["Moje jmeno", "Neco jineho"]

    # tak ted mame odkazy na ty filmy a vytahneme z toho obrazky
    #
    # (doc/"p/a/img").each do |img|
    #    puts img.attributes['class']
    #     end
    #


#    words.gsub!("?", " ")

    #@movies = doc
    
#    @movies = doc.search("//table//td")
#    string = "fdsffdas asdf this is a string"
#    string.slice!(2)
    # doc.to_s
     #doc.slice!(/(.)*kino premiery/)   #=> "sa st"

    #@movies = doc
#    @movies = Photo.find(:all, :include => :section)
  end
 

end
