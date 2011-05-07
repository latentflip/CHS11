
require 'rubygems'
require 'crack'
events = Crack::JSON.parse(IO.read('listings.json').to_s)

length = 500

File.open('eventdata.js', 'w') do |f|
  f.puts 'var events = ['
  events[0..length].each do |e|
    unless e['event_desc'] == "Apprentice"
      if (e['event_latitude'] && e['event_latitude'].to_f != 0.0)
        f.puts "{desc: '#{e['event_desc'].tr("'",'"')}', event_latitude: #{e['event_latitude']}, event_longitude: #{e['event_longitude']}, event_info: '#{e['event_info'].tr("'",'"')}', start_time: #{e['start_time_hhmm'].to_i}, end_time: #{e['end_time_hhmm']}, price: #{e['min_seat_price'].to_i} },"
      end
    end
  end
  f.puts '];'
end
