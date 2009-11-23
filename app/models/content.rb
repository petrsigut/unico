class Content < ActiveRecord::Base
  has_one :category

  require 'hpricot'
  require 'open-uri'
  require 'net/http'
  require 'logger'
  require "rexml/document"

  # do decode html entities in html2txt
#  require 'rubygems'
  #  script/server needs restart after installing new gem
  require 'htmlentities'

  # needed for XML XSLT
  require 'xml/libxml'
  require 'xml/libxslt'

  def self.mylayout
    "application"
  end

  def html2txt(html)
    # http://apidock.com/rails/ActionView/Helpers/SanitizeHelper/strip_tags
    
    html = ActionController::Base.helpers.strip_tags(html)
    
    coder = HTMLEntities.new
    html = coder.decode(html)

    # convert newlines from DOS to UNIX
    html.gsub!(/[\n\r]+/, "\n")
    html.gsub!(/^\s*/,'')
    #ruby -ne 'BEGIN{$\="\n"}; print $_.chomp' < 

#    html = sanitize(html)
  end

  def transform_xml2html(xml)
    xslt = XML::XSLT.new()
    xslt.xml = xml.to_s
    xslt.xsl = "#{RAILS_ROOT}/public/xml2html.xsl"
    xslt.serve()
  end
  
  def create_xml_head
    @xml = REXML::Document.new
    @kml = @xml.add_element 'kml', {'xmlns' => 'http://kml.ns.cz'}
    @kml_doc = @kml.add_element 'document'
    self.xml = @kml_doc
  end

  def create_xml_body(entity_name, entity_text)
    (@kml_doc.add_element entity_name).text = entity_text
    #(@kml_doc.add_element 'video').text = "http://tinyvid.tv/vfe/big_buck_bunny.mp4"
    self.xml = @kml_doc.to_s
  end

  def self.create_gallery(array_of_links)
    html_chunk = "<a href=\"#\" class=\"show\" ><img src=\"#{array_of_links[0]}\" alt=\"Slideshow Image 1\" rel=\"fdsafa\"  /></a>\n"
    array_of_links.each_with_index do |link, index|
      html_chunk += "<a href=\"#\"><img src=\"#{array_of_links[index+1]}\" alt=\"Slideshow Image 1\" /></a>\n"
    end

    html_chunk += '</div>'

  end

  # content.save_me - compare to old cached content in db and if we have newer
  # data, save to database, automaticly trigger creation of plaintext etc.,
  # and content.save at the end
  def save_me(query)
     content_old = Content.find_by_name(self.class.name)
  
     #logger.info "The old content: "
     #logger.info content_old
    
    #
    # happens only at first run, when we call ModelName.parse_content - it
    # creats just empty content_old so we can compare content to it
    if content_old.nil?
      content_old = Content.new
    end

    if ((content_old.rawhtml != self.rawhtml) or (content_old.xml != self.xml) or (query.empty?))
      # so we have newer content

      # automagicly creates xhtml from xml
      unless self.xml.nil?
        html_from_xml = transform_xml2html(self.xml)
        #self.xml = @kml_doc.to_s
        self.xhtml = html_from_xml
      end

      logger.info "Entering rawhtml processing"
      if not self.rawhtml.nil?
        if (PUSH_ENABLE and (query.empty?))
          Juggernaut.send_to_channel("location.reload();", [self.class.name])
          logger.info "Pushing:"
          logger.info self.class.name
        end
      end
      logger.info "Leaving HTML processing"

      # automagicly creates plain text from rawhtml or xhtml
      if not self.rawhtml.nil?
        txt = html2txt(self.rawhtml)
      else 
        txt = html2txt(self.xhtml)
      end
      
      if txt.empty?
        self.plaintext = nil
      else
        self.plaintext = txt
      end

      
      # Rails detect whether we change the content of record and if not,
      # update_at will not be updated. But we want to update it every time we
      # regenerete content
      self.updated_at = Time.now 
      self.created_at = content_old.created_at
      self.name = self.class.name
     
      # we do not want do save/cache contents with user's query
      if query.empty?
        self.save
        logger.fatal "Delete of content (if do not exist id will be NULL, it is OK)"
        puts Content.delete(content_old.id)
      end
      logger.fatal "SAVE ME"
      self
    else
      content_old
    end
  end

 
end
