class Model < Content

  def self.parse_content(query = {})
    content = Model.new
    content.name_human = "Human name"

    rawhtml = Hpricot(open(""))
    content.rawhtml = rawhtml.to_s

    content.save_me(query)
  end

end
