class Photoofthedaycom < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open("http://www.cocoa.de/news2/2009/03/photos/10/photo005.htm"))

    save_me
  end

  def self.parse_xml
    save_me
  end

end
