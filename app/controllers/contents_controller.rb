class ContentsController < ApplicationController
  def show
    @name = params[:id]
    Pcfilmtydne.parse_raw_html
    Pcfilmtydne.parse_xml

    @content = Content.find_by_name(@name) # udelat pres tridni promenou?
    # a pak v tom modelu aby si moh programator vybrat jestli se to obali
    # standardni HTML hlavickou a tak nebo ne...
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content.xml }
    end

  end

end
