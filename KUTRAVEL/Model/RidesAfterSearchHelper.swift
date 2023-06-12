

import Foundation


class RidesAfterSearchHelper {
    
    var delegate: RidesAfterSearchDelegate?
    var mutex = 0
    
    func saveHitchToDatabase(ride: Ride){
        
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT MAX(HitchId) As max FROM Hitch")
        print(result)
        if let dictionary = result.first as? [String: Int], let maxId = dictionary["max"] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: Date())
            let hitchId = maxId + 1
            DatabaseManager.sharedInstance.executeQuery(str: "INSERT INTO Hitch (Status, HitchId, RideId, UserEmail, Date) VALUES (2,'\(hitchId)','\(ride.rideId)','\(User.sharedInstance.email)','\(dateString)')")
            print("INSERT INTO Hitch (Status, HitchId, RideId, UserEmail, Date) VALUES (2,'\(hitchId)','\(ride.rideId)','\(User.sharedInstance.email)','\(dateString)')")
            self.delegate?.hitchIsSavedToFirebase()
        }
        
    }
 
}
