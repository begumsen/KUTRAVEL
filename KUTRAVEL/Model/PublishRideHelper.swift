

import Foundation

class PublishRideHelper {
    var delegate: PublishRideDelegate?
    var mutex: Int = 0
    init() {
    }
    
    func saveRide(from:String ,to:String, date:Date, fee :String, numberOfSeats: Int){
        
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT MAX(RideId) As max FROM Ride")
        print(result)
        if let dictionary = result.first as? [String: Int], let maxId = dictionary["max"] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            let rideId = maxId + 1
            DatabaseManager.sharedInstance.executeQuery(str: "INSERT INTO Ride VALUES (\(rideId),'\(User.sharedInstance.email)','\(dateString)',\(fee),'\(from)','\(to)',\(numberOfSeats))")
            self.delegate?.publishedToDatabase()
        }
    }
}


