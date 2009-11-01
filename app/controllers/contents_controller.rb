class ContentsController < ApplicationController
  layout :type_of_layout

  protect_from_forgery :only => [:index] 

  def send_data
    render :juggernaut => {:channels => [params[:send_to_channel]], :type => :send_to_channels} do |page|
      page.insert_html :top, 'chat_data', h(params[:chat_input])+"\n"
    end
    render :nothing => true
  end


  def index
    @contents = Content.find(:all)
    @layout = "application"
  end

  def show
    @name = params[:id]
    
    if params[:query] =~ /^\w+$/i
      @query = params[:query]
    end



    # at nam pod to @name nepodstrci nejakou prasarnu!

    # zautomatizovat to a udelat automaticky generovany index s prehledem...
    # (nahledem html v ramecku? to by bylo huste...)
    # http://infovore.org/archives/2006/08/02/getting-a-class-object-in-ruby-from-a-string-containing-that-classes-name/

    @name = @name.humanize
    @content = Content.find(:all, :select => 'name')

    found_in_db = false
    @content.each do |name|
      if @name == name.name
        found_in_db = true
      end
    end

    if found_in_db
      @content = Content.find_by_name(@name, :select => 'updated_at')
      if @content.updated_at < 10.seconds.ago # should be set by variable in content model
        (@name).constantize.parse_content
      end
      @content = Content.find_by_name(@name)
    else
       render :file => "#{RAILS_ROOT}/public/404.html",  :status => 404 and return  
    end


    # udelat pres tridni promenou?
    # a pak v tom modelu aby si moh programator vybrat jestli se to obali
    # standardni HTML hlavickou a tak nebo ne...
   
    # http://dev.rubyonrails.org/svn/rails/trunk/actionpack/lib/action_controller/mime_types.rb
    #  Mime::Type.register "image/jpg", :jpg
     Mime::Type.register "text/html", :xhtml
     Mime::Type.register "text/plain", :txt


    respond_to do |format|
      format.html # show.html.erb
      format.xhtml # show.xhtml.erb
      format.txt # show.txt.erb
      format.xml  { render :xml => @content.xml }
    end

  end
  
  private
    def type_of_layout
      @layout
    end

end
