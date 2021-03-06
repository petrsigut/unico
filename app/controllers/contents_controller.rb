class ContentsController < ApplicationController
  layout :type_of_layout

  protect_from_forgery :only => [:index] 

  # get data to show all contents
  def index
    category = params[:category_id]

    if (category == "0")
      @contents = Content.find(:all, :order => "name")
    else
      @contents = Content.find(:all, :order => "name", :conditions => ["category_id = ?", category])
    end
#    @categories = Category.find(:all)
    # http://keepwithinthelines.wordpress.com/2008/03/17/using-select-helper-in-rails/
    @categories =  Category.find(:all)
    @categories = [ ["all", 0] ] + @categories.map {|p| [ p.name, p.id ] }
    
    @layout = "index"
  end

  def show
    name = params[:id]

    @query = {}
    params.each do |param|
      if (param[0] =~ /^\w+$/i and
          param[1] =~ /^\w+$/i and
          param[0] != "id" and
          param[0] != "format" and
          param[0] != "action" and
          param[0] != "controller") then
        @query[param[0]] = param[1]
      end
    end

    #logger.fatal "Query"
    #logger.fatal @query.inspect
    #logger.fatal "Query NIL?"
    #logger.fatal @query.empty?

    # http://infovore.org/archives/2006/08/02/getting-a-class-object-in-ruby-from-a-string-containing-that-classes-name/

    name = name.humanize
    @content = Content.find(:all, :select => 'name')

    found_in_db = false
    @content.each do |content_name|
      if name == content_name.name
        found_in_db = true
      end
    end

    if found_in_db
      @content = Content.find_by_name(name, :select => 'updated_at')
      
      # the time should be setable by variable in content model
      @layout = (name).constantize.mylayout
      if (@content.updated_at < 10.seconds.ago or not @query.empty?)
        @content = (name).constantize.parse_content(@query) # make objeckt from var name
        logger.fatal "call parse_content"
      else # we want content from db
        @content = Content.find_by_name(name)
      end
    else
       render :file => "#{RAILS_ROOT}/public/404.html",  :status => 404 and return  
    end


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
