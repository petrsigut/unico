xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Petr Šigut | nové fotografie")
    xml.link("http://www.sigut.net/")
    xml.description("Fotogalerie.")
    xml.language('cs-cz')
      for photo in @filmik
        xml.item do
          xml.title(photo.names)
        end
      end
  }
}

