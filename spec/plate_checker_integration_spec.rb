require 'plate_transit_checker'
require 'json'

describe "integration" do
  let(:plates_json) {
    <<-JSON
      [
        {"plate": "ABC-0121", "date": "2016-07-04"  , "hour": "7:30"},
        {"plate": "ABC-512", "date": "2016-07-04"  , "hour": "19:29"},
        {"plate": "HBE-9381", "date": "2016-07-04"  , "hour": "12:30"},
        {"plate": "JKM-6126", "date": "2016-07-04"  , "hour": "07:45"},
        {"plate": "XCB-0123", "date": "2016-07-05"  , "hour": "19:10"},
        {"plate": "PBC-724", "date": "2016-07-05"  , "hour": "8:45"},
        {"plate": "HNM-0124", "date": "2016-07-05"  , "hour": "14:30"},
        {"plate": "TBC-0126", "date": "2016-07-05"  , "hour": "19:00"},
        {"plate": "MBC-675", "date": "2016-07-06"  , "hour": "7:00"},
        {"plate": "PCC-0126", "date": "2016-07-06"  , "hour": "18:30"},
        {"plate": "GHN-125", "date": "2016-07-06"  , "hour": "15:30"},
        {"plate": "ABC-0124", "date": "2016-07-06"  , "hour": "9:05"},
        {"plate": "HGB-0127", "date": "2016-07-07"  , "hour": "7:10"},
        {"plate": "GBC-0128", "date": "2016-07-07"  , "hour": "16:45"},
        {"plate": "ABC-0127", "date": "2016-07-07"  , "hour": "20:30"},
        {"plate": "JMC-0123", "date": "2016-07-07"  , "hour": "16:45"},
        {"plate": "HGB-0129", "date": "2016-07-08"  , "hour": "7:10"},
        {"plate": "GBC-0120", "date": "2016-07-08"  , "hour": "16:45"},
        {"plate": "ABC-0120", "date": "2016-07-08"  , "hour": "20:30"},
        {"plate": "JMC-0121", "date": "2016-07-08"  , "hour": "16:45"},
        {"plate": "ABC-0121", "date": "2016-07-09"  , "hour": "7:30"},
        {"plate": "ABC-0126", "date": "2016-07-10"  , "hour": "16:45"} 
      ]
    JSON
  }

  before do
    @results = []
    data_hash = JSON.parse(plates_json)
    data_hash.each do |p|  
      @results << PlateTransitChecker.new(p["plate"], p["date"], p["hour"]) 
    end
  end

  describe PlateTransitChecker do

    it "Should give you back the right last digit" do
      expect(@results[0].plate).to eq 1
      expect(@results[1].plate).to eq 2
      expect(@results[2].plate).to eq 1
      expect(@results[3].plate).to eq 6
      expect(@results[4].plate).to eq 3
      expect(@results[5].plate).to eq 4
      expect(@results[6].plate).to eq 4
      expect(@results[7].plate).to eq 6
      expect(@results[8].plate).to eq 5
      expect(@results[9].plate).to eq 6
      expect(@results[10].plate).to eq 5
      expect(@results[11].plate).to eq 4
      expect(@results[12].plate).to eq 7
      expect(@results[13].plate).to eq 8
      expect(@results[14].plate).to eq 7
      expect(@results[15].plate).to eq 3
      expect(@results[16].plate).to eq 9
      expect(@results[17].plate).to eq 0
      expect(@results[18].plate).to eq 0
      expect(@results[19].plate).to eq 1
      expect(@results[20].plate).to eq 1
      expect(@results[21].plate).to eq 6
    end

    it "Should give you back the right day" do
      # Take into acount that the day starts on Sunday(0)
      # Monday
      expect(@results[0].day).to eq 1
      expect(@results[1].day).to eq 1
      expect(@results[2].day).to eq 1
      expect(@results[3].day).to eq 1
      # Tuesday
      expect(@results[4].day).to eq 2
      expect(@results[5].day).to eq 2
      expect(@results[6].day).to eq 2
      expect(@results[7].day).to eq 2
      # Wednesday
      expect(@results[8].day).to eq 3
      expect(@results[9].day).to eq 3
      expect(@results[10].day).to eq 3
      expect(@results[11].day).to eq 3
      # Thursday
      expect(@results[12].day).to eq 4
      expect(@results[13].day).to eq 4
      expect(@results[14].day).to eq 4
      expect(@results[15].day).to eq 4
      # Friday
      expect(@results[16].day).to eq 5
      expect(@results[17].day).to eq 5
      expect(@results[18].day).to eq 5
      expect(@results[19].day).to eq 5
      # Satuday and Sunday
      expect(@results[20].day).to eq 6
      expect(@results[21].day).to eq 0
    end


    it "Should give you back the right time in seconds" do
      expect(@results[0].hour).to eq 27000
      expect(@results[1].hour).to eq 70140
      expect(@results[2].hour).to eq 45000
      expect(@results[3].hour).to eq 27900
      expect(@results[4].hour).to eq 69000
      expect(@results[5].hour).to eq 31500
      expect(@results[6].hour).to eq 52200
      expect(@results[7].hour).to eq 68400
      expect(@results[8].hour).to eq 25200
      expect(@results[9].hour).to eq 66600
      expect(@results[10].hour).to eq 55800
      expect(@results[11].hour).to eq 32700
      expect(@results[12].hour).to eq 25800
      expect(@results[13].hour).to eq 60300
      expect(@results[14].hour).to eq 73800
      expect(@results[15].hour).to eq 60300
      expect(@results[16].hour).to eq 25800
      expect(@results[17].hour).to eq 60300
      expect(@results[18].hour).to eq 73800
      expect(@results[19].hour).to eq 60300
      expect(@results[20].hour).to eq 27000
      expect(@results[21].hour).to eq 60300
    end

    it "Should return true if It can circulate or false it if cannot" do
      # Monday - Hour 7:30 Last Digit: 1 (Cannot Circulate)
      expect(@results[0].transit_checker).to eq false
      # Monday - Hour 19:30 Last Digit: 2 (Can Circulate)
      expect(@results[1].transit_checker).to eq false
      # Monday - Hour 12:30 Last Digit: 1 (Can Circulate)
      expect(@results[2].transit_checker).to eq true
      # Monday - Hour 07:45 Last Digit: 6 (Can Circulate)
      expect(@results[3].transit_checker).to eq true

      # Tuesday - Hour 19:10 Last Digit: 3 (Cannot Circulate)
      expect(@results[4].transit_checker).to eq false
      # Tuesday - Hour 16:45 Last Digit: 4 (Cannot Circulate)
      expect(@results[5].transit_checker).to eq false
      # Tuesday - Hour 8:45 Last Digit: 4 (Can Circulate)
      expect(@results[6].transit_checker).to eq true
      # Tuesday - Hour 19:00 Last Digit: 6 (Can Circulate)
      expect(@results[7].transit_checker).to eq true

      # Wednesday - Hour 7:00 Last Digit: 5 (Cannot Circulate)
      expect(@results[8].transit_checker).to eq false
      # Wednesday - Hour 18:30 Last Digit: 6 (Cannot Circulate)
      expect(@results[9].transit_checker).to eq false
      # Wednesday - Hour 15:30 Last Digit: 5 (Can Circulate)
      expect(@results[10].transit_checker).to eq true
      # Wednesday - Hour 9:05 Last Digit: 4 (Can Circulate)
      expect(@results[11].transit_checker).to eq true

      # Thursday - Hour 7:10 Last Digit: 7 (Cannot Circulate)
      expect(@results[12].transit_checker).to eq false
      # Thursday - Hour 16:45 Last Digit: 8 (Cannot Circulate)
      expect(@results[13].transit_checker).to eq false
      # Thursday - Hour 20:30 Last Digit: 7 (Can Circulate)
      expect(@results[14].transit_checker).to eq true
      # Thursday - Hour 16:45 Last Digit: 3 (Can Circulate)
      expect(@results[15].transit_checker).to eq true

      # Friday - Hour 7:10 Last Digit: 9 (Cannot Circulate)
      expect(@results[16].transit_checker).to eq false
      # Friday - Hour 16:45 Last Digit: 0 (Cannot Circulate)
      expect(@results[17].transit_checker).to eq false
      # Friday - Hour 20:30 Last Digit: 0 (Can Circulate)
      expect(@results[18].transit_checker).to eq true
      # Friday - Hour 16:45 Last Digit: 1 (Can Circulate)
      expect(@results[19].transit_checker).to eq true

      # Saturday - Hour 7:30 Last Digit: 1 (Can Circulate)
      expect(@results[20].transit_checker).to eq true
      # Sunday - Hour 16:45 Last Digit: 6 (Can Circulate)
      expect(@results[21].transit_checker).to eq true
    end
  end
end
