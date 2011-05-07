
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
  @event = {}
  @event['event_info'] = "Comedy, cabaret and non-stop fun. An insanely talented trio star in a show that celebrates the very best of their solo work. With an international background in vaudeville and burlesque, Mr B, Sarah Louise Young and Desmond O'Connor are united for the first time since their five-star, sell-out run of 'High Tease' with Blond Ambition at The Voodoo Rooms last year. All three have an extensive international following and widespread acclaim for their performances on the BBC, MTV and as far afield as Berlin, Amsterdam and New York. 'A thrill to watch' (Guardian)."

  @track1 = ""
  @event['event_info'][0..16].each_char do |c|
    if rand > 0.75
      @track1 << c
    else
      @track1 << " "
    end
  end
  @track2 = @event['event_info'][16..32]
  puts @track2
  haml :index
end
