class Youtube < Content
   attr_accessor :name

  def self.parse_raw_html
    @doc = Hpricot(open(""))

    save_me
  end

  def self.parse_xml
    #http://www.youtube.com/get_video?video_id=v_4-zRVFLnY&t=vjVQa1PpcFMoUet4DvWYTUuw    
    save_me
  end

end
