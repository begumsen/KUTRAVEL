import Foundation


class RideRequestDataSource {
    
    private var hitchArray: [Hitch] = []
    private var rideRequestArray: [RideRequest] = []
    var delegate: RideRequestDataDelegate?
    var requestCount = 0
    var rideCell: Ride?
    
    init() {
    }
    
    func getListOfRideRequest(ride: Ride) {
        rideRequestArray.removeAll()
        hitchArray.removeAll()
        print("getListOfRideRequestModel")
        self.rideCell = ride
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT COUNT(*) As count FROM Hitch WHERE RideId = \(ride.rideId)")
        print("hitch: \(result)")
        if let dictionary = result.first as? [String: Int], let count = dictionary["count"] {
            print(count)
            if (count == 0) {
                print("no data in ride Request")
                self.delegate?.noDataInRideRequest()
            }
            else {
                print("hitches")
                let hitches = DatabaseManager.sharedInstance.executeQuery(str: "SELECT HitchId, Hitch.UserEmail, status, FullName, Major, Class, PhoneNumber FROM Hitch INNER JOIN Ride ON Hitch.RideId = Ride.RideId INNER JOIN User ON User.Email = Hitch.UserEmail WHERE Ride.RideId = \(ride.rideId)")
                print(hitches)
                for dict in hitches {
                    if let hitchId = dict["HitchId"] as? Int,
                       let hitchhikerMail = dict["UserEmail"] as? String,
                       let status = dict["status"] as? Int,
                       let hitchhikerName = dict["FullName"] as? String,
                       let hitchhikerMajor = dict["Major"] as? String,
                       let hitchhikerGradeLevel = dict["Class"] as? String,
                       let hitchhikerPhoneNumber = dict["PhoneNumber"] as? String {
                        print("succesfull hitch")
                       let newRideRequest = RideRequest(hitchhikeId: "\(hitchId)", hitchhikerMail: hitchhikerMail, rideId: ride.rideId, status: status, ride: ride, hitchhikerName: hitchhikerName, hitchhikerMajor: hitchhikerMajor, hitchhikerGradeLevel: hitchhikerGradeLevel, hitchhikerPhoneNumber: hitchhikerPhoneNumber)
                        self.rideRequestArray.append(newRideRequest)
                       }
                }
                self.delegate?.rideRequestListLoaded()
                
            }
        }
        
    }
    
 
    func getNumberOfRideRequest() -> Int {

        return rideRequestArray.count
    }
    
    func getRideRequest(for index:Int) -> RideRequest? {
        guard index < rideRequestArray.count else {
            return nil
        }
        return rideRequestArray[index]
    }
}
