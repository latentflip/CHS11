
# DataMapper setup - this will use the Rack env variable 'DATABASE_URL' if available
# (it is provided by Heroku). Otherwise, create or use local SQLite development.db
#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

# Create models here, e.g.
# class Person
# 	include DataMapper::Resource
# 	property :id, Serial
# 	property :name, String
# end

# Automated schema changes
#DataMapper.auto_upgrade!

# Routes

#events = Crack::JSON.parse(IO.read('listings.json').to_s)

get "/css/:sheet.css" do |sheet|
  sass :"css/#{sheet}"
end

get "/" do
  #@event = events.choice



  haml :index
end
