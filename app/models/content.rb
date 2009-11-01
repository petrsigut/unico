class Content < ActiveRecord::Base
  require 'hpricot'
  require 'open-uri'
  require 'net/http'
  require 'logger'
  require "rexml/document"

  # needed for XML XSLT
  require 'xml/libxml'
  require 'xml/libxslt'

  def self.html2txt(html)
    # http://apidock.com/rails/ActionView/Helpers/SanitizeHelper/strip_tags
    html = ActionController::Base.helpers.strip_tags(html)
#    html = sanitize(html)
  end

  def self.transform_xml2html(xml)
    xslt = XML::XSLT.new()
    xslt.xml = xml.to_s
    xslt.xsl = "#{RAILS_ROOT}/public/xml2html.xls"
    xslt.serve()
  end
  
  # private nebo tak neco?
  def self.create_xml_head
    @xml = REXML::Document.new
    @kml = @xml.add_element 'kml', {'xmlns' => 'http://kml.ns.cz'}
    @kml_doc = @kml.add_element 'document'
  end

  def self.create_xml_body(entity_name, entity_text)
    (@kml_doc.add_element entity_name).text = entity_text
    #(@kml_doc.add_element 'video').text = "http://tinyvid.tv/vfe/big_buck_bunny.mp4"
  end

  def self.create_gallery(array_of_links)
    html_chunk = "<a href=\"#\" class=\"show\" ><img src=\"#{array_of_links[0]}\" alt=\"Slideshow Image 1\" rel=\"fdsafa\"  /></a>\n"
    array_of_links.each_with_index do |link, index|
      html_chunk += "<a href=\"#\"><img src=\"#{array_of_links[index]}\" alt=\"Slideshow Image 1\" /></a>\n"
    end

    html_chunk += '</div>'

  end

  def self.save_me
    # tohle až do konce můžu zoobecnit pro všechny třídy...
    @content = Content.find_by_name(self.name) # udelat pres tridni promenou?
    
    if @content.nil?
      @content = Content.new
      @content.name = self.name
    end
    
    @content.name_human = @name_human
   
    if @kml_doc.nil?
      @content.xml = nil
    else
      html_from_xml = transform_xml2html(@kml_doc)
      @content.xml = @kml_doc.to_s
      @content.xhtml = html_from_xml
    end

    logger.info "Entering HTML saving"
    if @rawhtml.nil?
      @content.rawhtml = nil
    else
      if PUSH_ENABLE and (@content.rawhtml != @rawhtml.to_s)
        unless @content.id.nil? # could be if it is first calling of new model
          Juggernaut.send_to_channel("location.reload();", [@content.id])
          logger.fatal "push happen"
          logger.fatal @content.name
        end
      else
        logger.info "push NOT happen"
      end
      @content.rawhtml = @rawhtml.to_s
      txt = html2txt(@rawhtml.to_s)
      @content.plaintext = txt
    end
    logger.info "Leaving HTML saving"
    
    # Rails detect whether we change the content of record and if not,
    # update_at will not be updated. But we want to update it every time we
    # regenerete content
    @content.updated_at = Time.now 
    @content.save
  end


 
end
