class Sigutgalerie < Content
  def self.mylayout
    "slideshow"
  end



  def self.parse_content(query = {})
    content = Sigutgalerie.new
    content.name_human = "Fotogalerie Petr Šigut"

    url = "http://www.sigut.net/"

    rawhtml = Hpricot(open(url))
    rawhtml = rawhtml.at("//span[@class='photos']")
    rawhtml = rawhtml.search("//img")

    slideshow = []
    rawhtml.each do |image|
      slideshow << (url + image.attributes['src'])
    end

    content.rawhtml = create_gallery(slideshow)
    content.save_me(query)
  end

end
