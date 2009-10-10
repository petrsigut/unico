class PcfilmtydneController < ApplicationController
  require 'hpricot'
  # na otvirani urlek
  require 'open-uri'
  require 'net/http'
  # require 'builder'
   require "rexml/document"


  def index
    # tady tahaji z imdb:
    # http://www.weheartcode.com/2007/04/03/scraping-imdb-with-ruby-and-hpricot/
    
    # film tydne ve Spalicku
    @doc = Hpricot(open("http://www.palacecinemas.cz/Default.asp?city=1&cin=411&td=2008-09-21&id=0&uid=7c18c3c1b38f4081e601bf2d5eb63b73"))
    #doc = doc.to_s()
    #@movies = @doc.at("//table/#kurzy_tisk").xpath
    @doc = @doc.search("//div[@class='frame red']")

    #@movies = @movies.to_s()

    # @movies.gsub!(/[\n\r]/, "")
    # /m nam zajisti ze neresi newlines
    # http://www.regular-expressions.info/ruby.html
#    @movies.gsub!(/(.)*<!-- Begin kurzak CNB -->/m, "")   #=> "sa st"
 #   @movies.gsub!(/<!-- End kurzak CNB -->(.)*/m, "")   #=> "sa st"
#    @movies.gsub!(/tento mesic vychazi na DVD(.)*/m, "")   #=> "sa st"
    #@movies = Hpricot(@movies)


    @label1 = @doc.search("//h3")
    @label2 = @doc.search("//h2")
    @image1 = @doc.at("//img")
    @image1 = @image1.attributes['src']
    @label3 = @doc.at("//p")

#    @x = Builder::XmlMarkup.new
#    @x.instruct!
#    @x.label @label1

    @xml = REXML::Document.new
    @kml = @xml.add_element 'kml', {'xmlns' => 'http://kml.ns.cz'}
    @kml_doc = @kml.add_element 'document'
    (@kml_doc.add_element 'label').text = @label1
    (@kml_doc.add_element 'label').text = @label2
    (@kml_doc.add_element 'image').text = @image1
    (@kml_doc.add_element 'label').text = @label3
    #(@kml_doc.add_element 'video').text = "http://tinyvid.tv/vfe/big_buck_bunny.mp4"


    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml }
    end

#<label>obsah labelu1</label>
    #


    # ted musime nejak kesovat ten obrazek, takhle?
    # http://www.ruby-forum.com/topic/133981
    #
    
#--------------------------------------------------
#     Net::HTTP.start( 'www.sigut.net' ) { |http|
#         resp = http.get( '/fotky/_obr300.jpg' )
#           open( '/tmp/ror_vs_c_asm.jpg', 'wb' ) { |file|
#                 file.write(resp.body)
#         }
#     }
# 
#-------------------------------------------------- 



  end
end
