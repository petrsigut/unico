class Photoofthedaycom < Content
   attr_accessor :name

  def self.parse_content
    year = Time.now.strftime("%Y")
    # with leading zeros
    month = Time.now.strftime("%m")
    day = Time.now.strftime("%d")
   
    create_xml_head
    
    @rawhtml = []
    10.times.with_index  do |x, index|
      if index < 9
        @rawhtml << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo00#{index+1}.jpg"
      else
        @rawhtml << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo0#{index+1}.jpg"
      end
      create_xml_body("image", @rawhtml[index])
    end

    @rawhtml = create_gallery(@rawhtml)

    save_me
  end


end
