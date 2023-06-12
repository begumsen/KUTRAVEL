
import Foundation

class StatsDataSource {
    
    
    var delegate: StatsDataDelegate?
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    
    init() {
    }
    
    func getStats(){
        first = "AVERAGE FEE BY MAJORS:\nMAJOR || AVERAGE FEE\n"
                second = "Minimum FEE FOR DESTINATIONS:\nDESTINATION || MIN FEE || RIDER\n"
                third =    "GOLD USERS:\n"
                fourth =    "MOST POPULAR DESTINATIONS:\nDESTINATION || RIDE COUNT\n"
                let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT User.major, AVG(Ride.Fee) AS average_fee FROM Ride JOIN User ON Ride.UserEmail = User.email GROUP BY User.major LIMIT 3")
                for dict in result {
                    if let averageFee = dict["average_fee"] as? Double,
                       let major = dict["major"] as? String {
                            first = first + " " + major + " || " + String(averageFee) + "\n"
                        }
                }
                
                let result2 = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Ride.ToLoc AS destination, MIN(Ride.Fee) AS min_fee, User.FullName AS rider_name FROM Ride JOIN User ON Ride.UserEmail = User.email GROUP BY Ride.ToLoc, User.FullName HAVING MIN(Ride.Fee) = (SELECT MIN(Fee) FROM Ride AS R WHERE R.ToLoc = Ride.ToLoc) LIMIT 3")
                for dict in result2 {
                    if let destination = dict["destination"] as? String,
                       let minFee = dict["min_fee"] as? Int,
                       let riderName = dict["rider_name"] as? String{
                            second = second + " " + destination + " || " + String(minFee) + " || " + riderName + "\n"
                        }
                }
                print(second)
                
                let result3 = DatabaseManager.sharedInstance.executeQuery(str: "SELECT User.FullName FROM User JOIN Review ON User.Email = Review.ReviewedMail WHERE Review.Comment LIKE '%Great%' GROUP BY User.FullName HAVING AVG(Review.Rating) >= 4 LIMIT 3")
                for dict in result3 {
                    if let fullName = dict["FullName"] as? String{
                            third = third + " " + fullName +  "\n"
                        }
                }
                
                let result4 = DatabaseManager.sharedInstance.executeQuery(str: "SELECT ToLoc AS PopularLocation, COUNT(*) AS RideCount FROM Ride GROUP BY ToLoc ORDER BY RideCount DESC LIMIT 3")
                print(result4)
                for dict in result4 {
                    if let rideLocation = dict["PopularLocation"] as? String,
                       let rideCount = dict["RideCount"] as? Int{
                        fourth = fourth + " " + rideLocation + " || " + String(rideCount) + "\n"
                        }
                }
                print(fourth)
                

                self.delegate?.statsAreLoaded()
    }
}
