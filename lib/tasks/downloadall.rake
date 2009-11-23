desc "Iterate thru all contents and download new content, if it differs from
old, then push"
task(:downloadall => :environment) do
 # @contents = Content.find(:all)
 # @contents.each do |content|
 basedir = 'app/models/'
 Dir.chdir(basedir)
 files = Dir.glob("*.rb")
 files.each do |model|
   model.chomp!('.rb')
   if (model != 'sablona' and model != 'content' and model != 'category')
     (model).humanize.constantize.parse_content
     puts (model).humanize + " called parse_content"
   end
 end

 #   puts content.name
 #   puts "parsed"
#  end
end
