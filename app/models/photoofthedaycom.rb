class Photoofthedaycom < Content
   attr_accessor :name

  def self.parse_raw_html
    year = Time.now.strftime("%Y")
    # with leading zeros
    month = Time.now.strftime("%m")
    day = Time.now.strftime("%d")
   
    @doc = []
    10.times.with_index  do |x, index|
      if index < 9
        @doc << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo00#{index+1}.jpg"
      else
        @doc << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo0#{index+1}.jpg"
      end
    end

    @doc = create_gallery(@doc)
    logger.fatal "Logujem"
    logger.fatal @doc

    save_me
  end

  def self.parse_xml
    save_me
  end

end
