class ContentsController < ApplicationController
  def show
    @name = params[:id]

    # at nam pod to @name nepodstrci nejakou prasarnu!

    # zautomatizovat to a udelat automaticky generovany index s prehledem...
    # (nahledem html v ramecku? to by bylo huste...)
    case @name
    when "pcfilmtydne"
      Pcfilmtydne.parse_raw_html
      Pcfilmtydne.parse_xml
    when "csfddokin"
      Csfddokin.parse_raw_html
      Csfddokin.parse_xml
    when "cnbkurzy"
      Cnbkurzy.parse_raw_html
      Cnbkurzy.parse_xml
    end

    @content = Content.find_by_name(@name) # udelat pres tridni promenou?
    # a pak v tom modelu aby si moh programator vybrat jestli se to obali
    # standardni HTML hlavickou a tak nebo ne...
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content.xml }
    end

  end

end