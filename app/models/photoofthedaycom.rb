class Photoofthedaycom < Content

  def self.mylayout
    "slideshow"
  end

  def self.parse_content(query = {})
    content = Photoofthedaycom.new
    content.name_human = "Photo of the Day"
    content.category_id = 3


    year = Time.now.strftime("%Y")
    # with leading zeros
    month = Time.now.strftime("%m")
    day = Time.now.strftime("%d")
   
    content.create_xml_head
    
    rawhtml = []
    10.times.with_index  do |x, index|
      if index < 9
        rawhtml << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo00#{index+1}.jpg"
      else
        rawhtml << "http://www.cocoa.de/news2/#{year}/#{month}/photos/#{day}/photo0#{index+1}.jpg"
      end
      content.create_xml_body("image", rawhtml[index])
    end

    content.rawhtml = create_gallery(rawhtml)

    content.save_me(query)
  end


end
