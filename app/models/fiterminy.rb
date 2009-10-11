class Fiterminy < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open("http://www.fi.muni.cz/studies/dates.xhtml"))
    @doc = @doc.at("//table")

    save_me
  end

  def self.parse_xml
    save_me
  end

end
