class Timetest < Content

  def self.parse_content(query = {})
    content = Timetest.new
    
    content.rawhtml = Time.now.to_s

    content.save_me(query)
  end

end
