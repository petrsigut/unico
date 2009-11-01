desc "Iterate thru all contents and download new content, if it differs from
old, then push"
task(:push => :environment) do
  @contents = Content.find(:all)
  @contents.each do |content|
    (content.name).constantize.parse_content
    puts content.name
    puts "parsed"
  end
end
