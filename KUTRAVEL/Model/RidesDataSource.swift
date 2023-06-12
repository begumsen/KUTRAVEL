
import Foundation


class RidesDataSource{
    
    private var ridesArray: [Ride] = []
    private var rideCount: Int = 0
    var globalDistance = 0.0
    private var rideSearchArray: [RideSearch?] = []
    
    
    var delegate: RidesDataDelegate?
    
    init() {
    }
    
    func getListOfRidesWithShowAll() {
        
        let rides = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Ride.RideId, Ride.UserEmail, User.FullName, User.Major, Ride.Date, Ride.Fee, Ride.FromLoc, Ride.ToLoc, Ride.NoOfSeats, User.Smoking, User.Chattiness, AVG(Review.Rating) AS AveragePoints FROM Ride JOIN User ON Ride.UserEmail = User.Email LEFT JOIN Review ON User.Email = Review.ReviewedMail WHERE Ride.Date > CURDATE() GROUP BY Ride.RideId ORDER BY AveragePoints DESC")
                
                /*SELECT Ride., AVG(Review.Rating) AS AveragePoints FROM Ride JOIN User ON Ride.UserEmail = User.Email LEFT JOIN Review ON User.Email = Review.ReviewedMail WHERE Ride.Date > CURDATE() GROUP BY Ride.RideId ORDER BY AveragePoints DESC*/
                let hitchedRideIds = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Ride.RideId FROM Ride JOIN Hitch ON Ride.RideId = Hitch.RideId WHERE Hitch.UserEmail = '\(User.sharedInstance.email)'")
                print("hitched ride ids coming!")
                print(hitchedRideIds)
                var hitchedRideIdsList: [Int] = []
                for dict in hitchedRideIds {
                    hitchedRideIdsList.append(dict["RideId"] as! Int)
                }
                print("hitched ride ids list coming!")
                print(hitchedRideIdsList)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                for dict in rides {
                    
                    if let rideId = dict["RideId"] as? Int,
                       let smoking = dict["Smoking"] as? Int,
                       let chattiness = dict["Chattiness"] as? Int,
                       let userEmail = dict["UserEmail"] as? String,
                       let fullName = dict["FullName"] as? String,
                       let major = dict["Major"] as? String,
                       let date = dict["Date"] as? String,
                       let fee = dict["Fee"] as? Int,
                       let fromLoc = dict["FromLoc"] as? String,
                       let toLoc = dict["ToLoc"] as? String,
                       let noOfSeats = dict["NoOfSeats"] as? Int {
                        var smokingFlag = false;
                        var chattinesFlag = false
                        var isHitched = false
                        if(smoking == 1){
                            smokingFlag = true
                        }
                        if(chattiness == 1){
                            chattinesFlag = true
                        }
                        if(hitchedRideIdsList.contains(rideId)){
                            isHitched = true
                        }
                        let newRide = Ride(rideId: "\(rideId)", fromLocation: fromLoc, toLocation: toLoc, date: dateFormatter.date(from: date)!, seatAvailable: noOfSeats, fee: fee, mail: userEmail, hitched: isHitched)
                        self.ridesArray.append(newRide)
                        print("ride:")
                        print(newRide)
                        print("ride appended")
                        print(User.sharedInstance.getNoSmokingPreference())
                        var newRideSearch = RideSearch(
                            ride: newRide,
                            riderFullName: fullName,
                            riderMajor: major
                        )
                        if(User.sharedInstance.email != userEmail && User.sharedInstance.getNoSmokingPreference() == smokingFlag && User.sharedInstance.getSilentRidePreference() == chattinesFlag ){
                            print("newRideSearch:")
                            print(newRideSearch)
                            self.rideSearchArray.append(newRideSearch)
                        }
                       }
                }
                
                print(self.rideSearchArray)
                self.delegate?.ridesListLoaded()
        

        
        }
    
    
    func getListOfRidesWithoutShowAll(to: String, toNeighbourhood: String, from: String, date: Date ) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
        let rides = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Ride.RideId, Ride.UserEmail, User.FullName, User.Major, Ride.Date, Ride.Fee, Ride.FromLoc, Ride.ToLoc, Ride.NoOfSeats, User.Smoking, User.Chattiness, AVG(Review.Rating) AS AveragePoints FROM Ride JOIN User ON Ride.UserEmail = User.Email LEFT JOIN Review ON User.Email = Review.ReviewedMail WHERE Ride.Date > CURDATE() AND ride.fromloc = '\(from)' AND RIDE.TOLOC = '\(to)' AND RIDE.DATE =  '\(dateString)' GROUP BY Ride.RideId ORDER BY AveragePoints DESC")
                
                /*SELECT Ride.RideId, Ride.UserEmail, User.FullName, User.Major, Ride.Date, Ride.Fee, Ride.FromLoc, Ride.ToLoc, Ride.NoOfSeats, User.Smoking, User.Chattiness, AVG(Review.Rating) AS AveragePoints FROM Ride JOIN User ON Ride.UserEmail = User.Email JOIN Review ON User.Email = Review.ReviewedMail WHERE Ride.Date > CURDATE() AND ride.fromloc = '\(from)' AND RIDE.TOLOC = '\(to)' AND RIDE.DATE =  '\(dateString)' GROUP BY Ride.RideId ORDER BY AveragePoints DESC*/
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let hitchedRideIds = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Ride.RideId FROM Ride JOIN Hitch ON Ride.RideId = Hitch.RideId WHERE Hitch.UserEmail = '\(User.sharedInstance.email)'")
                print("hitched ride ids coming!")
                print(hitchedRideIds)
                var hitchedRideIdsList: [Int] = []
                for dict in hitchedRideIds {
                    hitchedRideIdsList.append(dict["RideId"] as! Int)
                }
                for dict in rides {
                    if let rideId = dict["RideId"] as? Int,
                       let smoking = dict["Smoking"] as? Int,
                       let chattiness = dict["Chattiness"] as? Int,
                       let userEmail = dict["UserEmail"] as? String,
                       let fullName = dict["FullName"] as? String,
                       let major = dict["Major"] as? String,
                       let date = dict["Date"] as? String,
                       let fee = dict["Fee"] as? Int,
                       let fromLoc = dict["FromLoc"] as? String,
                       let toLoc = dict["ToLoc"] as? String,
                       let noOfSeats = dict["NoOfSeats"] as? Int {
                        var isHitched = false
                        if(hitchedRideIdsList.contains(rideId)){
                            isHitched = true
                        }
                        var smokingFlag = false;
                        var chattinesFlag = false
                        if(smoking == 1){
                            smokingFlag = true
                        }
                        if(chattiness == 1){
                            chattinesFlag = true
                        }
                        if(hitchedRideIdsList.contains(rideId)){
                            isHitched = true
                        }
                        let newRide = Ride(rideId: "\(rideId)", fromLocation: fromLoc, toLocation: toLoc, date: dateFormatter.date(from: date)!, seatAvailable: noOfSeats, fee: fee, mail: userEmail, hitched: isHitched)
                        self.ridesArray.append(newRide)
                        print("ride:")
                        print(newRide)
                        print("ride appended")
                        var newRideSearch = RideSearch(
                            ride: newRide,
                            riderFullName: fullName,
                            riderMajor: major
                        )
                        if(User.sharedInstance.fullName != fullName && User.sharedInstance.getNoSmokingPreference() == smokingFlag && User.sharedInstance.getSilentRidePreference() == chattinesFlag ){
                            self.rideSearchArray.append(newRideSearch)
                        }
                       }
                }
                
                print(self.rideSearchArray)
                self.delegate?.ridesListLoaded()
        
        
        }
    
    func getRiderReviewPoint(riderEmail: String) -> String{
        let reviews = DatabaseManager.sharedInstance.executeQuery(str: "SELECT SUM(Rating)/COUNT(*) As Point FROM Review WHERE ReviewedMail = '\(riderEmail)' GROUP BY ReviewedMail")
        print("review Point")
        print(riderEmail)
        print(reviews)
        for dict in reviews {
            if let point = dict["Point"] as? Double {
                print("review present")
                let roundedValue = round(point * 10) / 10.0
                return "\(roundedValue)"
            } else {
                return "no data"
            }
        }
        return "no data"
    }
    
    func getNumberOfRides() -> Int {
        return rideSearchArray.count
    }
    
    func getRide(for index: Int) -> RideSearch? {
        guard index < rideSearchArray.count else {
            return nil
        }
        return rideSearchArray[index]
    }
    
    
    func parseAddress(address: String) -> String {
            var parsedAddress = address
            parsedAddress = parsedAddress.replacingOccurrences(of: " ", with: "%2C")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ı", with: "i")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ğ", with: "G")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ğ", with: "g")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ü", with: "U")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ü", with: "u")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ş", with: "S")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ş", with: "s")
            parsedAddress = parsedAddress.replacingOccurrences(of: "İ", with: "I")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ö", with: "O")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ö", with: "o")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ç", with: "C")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ç", with: "c")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Â", with: "A")
            parsedAddress = parsedAddress.replacingOccurrences(of: "â", with: "a")
            return parsedAddress
        }
}

