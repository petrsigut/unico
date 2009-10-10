class Cnbkurzy < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open("http://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.jsp"))
    @doc = @doc.search("//table[@class='kurzy_tisk']")

    
#    @kurzy = {}
#    (@movies/"//table//tr").each do |row|
#      (row/"//td").each do |cell|
#        logger.fatal cell.inner_html
#      end
#        logger.fatal "XXX"
#    end



    save_me
  end

  def self.parse_xml
    save_me
  end

end
