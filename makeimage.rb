#File.open('new_icon.png', 'wb') do |file|
#  file << (IO.read('listings_short.json').to_s.unpack('m')).first
#end

require 'rubygems'
require 'wavefile'
require 'crack/json'
require 'sequence'
require 'png2'

                                # sample_rate,
                                # bits_per_sample
module MusicMaker
  SAMPLERATE = 44100.0
end






events = Crack::JSON.parse(IO.read('listings.json').to_s)

class BitTrack
  attr_accessor :string, :length, :samples, :amplitude
  def initialize(string,track_length, amplitude)
    @length = string.length
    @rate = (track_length/@length.to_f).to_i
    @amplitude = amplitude
    @samples = []
    string.each_byte do |c|
      @samples += [c]*@rate
    end
  end
  def get_sample(i)
    amplitude * @samples[i % length]/100.0
  end
end


class EventSound
  attr_accessor :tracks, :event, :length
  def initialize(event,length)
    @event ||= event
    @tracks ||= []
    @length ||= length
    build_track
  end
  def build_track
    #@tracks << Sequence.new([10,30,50], 100000, [0.2])
    @tracks << Sine.new(event['start_time_hhmm'].to_i,0.5)
    @tracks << Sine.new(1.5*event['end_time_hhmm'].to_i,0.25)
    @tracks << Sequence.new(event['event_info'], 16000)
    @tracks << Sequence.new(event['event_info'], 2000, [0.2])
    @tracks << BitTrack.new(event['event_info'], 4000,0.15)
  end

  def get_sample(i)
    samples = tracks.map {|s| s.get_sample(i)}
    #samples.inject(1) {|product,n| product = product * n}
    samples.inject(0) {|sum,n| sum += n/samples.length.to_f}
  end
end

length = 1*44.1*1000*10

events[0..32].each_with_index do |e,i|
  event_sound = EventSound.new(e, length)

  samples = []
  #data = []
  #new_data = []
  #e['event_info'][0..200].each_byte do |c|
  #  new_data << ((c - 100)*10) % 255
  #  if new_data.length == 3
  #    data << new_data
  #    new_data = []
  #  end
  #end

  #event_image = EventImage.new(data, "event_#{i}")
  #event_image.save_image

  (0..length).each do |sample|
    samples << event_sound.get_sample(sample)
  end
  w = WaveFile.new(1, 44100, 16)  # num_channels,
  w.sample_data = samples
  w.save("track-#{i}.wav")
end



#p events.first
#exit
#base_freq = 200
#samples = []
#freqs = []
#sounds[0..1000].each_byte do |c|
#  freqs << base_freq*c/50.0
#end
#
#delta = 0.1
#freqs.each do |freq|
#  s = Sine.new(freq)
#  (0..1024).each do |i|
#    sample = s.get_sample(i)
#    if (i > 512) && (sample.abs < delta)
#      puts 'broke'
#      break
#    else
#      samples << sample
#    end
#  end
#end
#
#p samples[0..100]



