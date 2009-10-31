class Fiterminy < Content
   attr_accessor :name

  def self.parse_content
    @rawhtml = Hpricot(open("http://www.fi.muni.cz/studies/dates.xhtml"))
    @rawhtml = @rawhtml.at("//table")

    save_me
  end

end
