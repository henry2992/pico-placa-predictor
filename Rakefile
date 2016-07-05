require 'json'


task :default => [:run]

desc "pretty print review tweets generated from reviews and movies json"
task "run" do

  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'plate_transit_checker'

  # load the data files into strings for you
  plates_json = File.read("data/plates.json")
  data_hash = JSON.parse(plates_json)
  # movies_json = File.read("data/movies.json")
  # call the app, passing the data as strings containing JSON
  days = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado']

  data_hash.each do |p|  
    puts "-----"
    plate =  PlateTransitChecker.new(p["plate"], p["date"], p["hour"])
    
    message_true = "La placa #{p['plate']} puede circular durante #{p["date"]} (#{days[plate.day]}) a las #{p["hour"]} "
    message_false = "La placa #{p['plate']} no puede circular durante #{p["date"]} (#{days[plate.day]}) a las #{p["hour"]}"

    puts plate.transit_checker ? message_true : message_false
    
  end


 

end
