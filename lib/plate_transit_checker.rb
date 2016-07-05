class PlateTransitChecker

  attr_accessor :plate, :day, :hour

  def initialize(plate, date, hour)
  	@plate = get_last_digit(plate)
  	@day =  get_day(date)
  	@hour = get_time_of_day(hour)
  end

  def get_last_digit(plate)
 	return plate.split('').last.to_i
  end
	
  def get_day(date)
  	dateArray = date.split('-')
  	return Date.new(dateArray[0].to_i, dateArray[1].to_i, dateArray[2].to_i).wday
  end

  def get_time_of_day(hour)
	h = DateTime.strptime(hour, '%H:%M')
	return (h.hour * 3600 ) + ( h.min * 60 )
  end

  def transit_checker
  	@day.between?(1,5) && (@hour.between?(25200,34199) || @hour.between?(57600,70199) ) ? check_plate : true
  end

  def check_plate
  	if @day == 1 && (@plate == 1 || @plate == 2)
		return false
	elsif @day == 2 && (@plate == 3 || @plate == 4)
		return false
	elsif @day == 3 && (@plate == 5 || @plate == 6)
		return false
	elsif @day == 4 && (@plate == 7 || @plate == 8)
		return false
	elsif @day == 5 && (@plate == 9 || @plate == 0)
		return false
	else			
		return true
	end
  end

end
