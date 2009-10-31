class Model < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open(""))

    save_me
  end

  def self.parse_xml
    save_me
  end

end
