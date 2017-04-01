namespace :attendance do
 desc "Run the periodic task for creating attendance objects for endivitual developer"

 task create_dev: :environment 
 def objects(model)
 	model.first
 end	
end