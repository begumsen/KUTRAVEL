//
//  myRidesDataSource.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
//

import Foundation

class MyRidesDataSource {
    
    private var myRidesArray: [Ride] = []
    
    var delegate: MyRidesDataDelegate?
    
    init() {
    }
    
    func getListOfMyRides(){
        myRidesArray.removeAll()
        print("getListOfMyRidesModel")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let dateString = dateFormatter.string(from: today)
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT COUNT(*) As count FROM Ride WHERE UserEmail = '\(User.sharedInstance.email)' AND Date > \(dateString)")
        print(result)
        if let dictionary = result.first as? [String: Int], let exist = dictionary["count"] {
            print(exist)
            if(exist == 0) {
                self.delegate?.noDataInMyRides()
            }
            else {
                print("currentRide")
                let myRides = DatabaseManager.sharedInstance.executeQuery(str: "SELECT RideId, UserEmail, Date, Fee, FromLoc, ToLoc, NoOfSeats FROM Ride WHERE UserEmail = '\(User.sharedInstance.email)' AND Date > \(dateString)")
                print(myRides)
                for dict in myRides {
                    if let rideId = dict["RideId"] as? Int,
                       let userEmail = dict["UserEmail"] as? String,
                       let date = dict["Date"] as? String,
                       let fee = dict["Fee"] as? Int,
                       let fromLoc = dict["FromLoc"] as? String,
                       let toLoc = dict["ToLoc"] as? String,
                       let noOfSeats = dict["NoOfSeats"] as? Int {
                        print("succesfull ride")
                        let newRide = Ride(rideId: "\(rideId)", fromLocation: fromLoc, toLocation: toLoc, date: dateFormatter.date(from: date)!, seatAvailable: noOfSeats, fee: fee, mail: userEmail, hitched: false)
                        self.myRidesArray.append(newRide)
                       }
                }
               
                self.delegate?.myRidesListLoaded()
                /**
                 var newRide = Ride (
                     rideId: rideId,
                     fromLocation: document.get("from") as? String ?? "",
                     fromNeighbourhoodLocation: document.get("fromNeighbourhood") as? String ?? "",
                     toLocation: document.get("to") as? String ?? "",
                     toNeighbourhoodLocation: document.get("toNeighbourhood") as? String ?? "",
                     date: dateUnwrapped,
                     time: timeUnwrapped,
                     seatAvailable: document.get("numberOfSeats") as? Int ?? 1,
                     fee: document.get("fee") as? Int ?? 0,
                     mail: document.get("mail") as? String ?? "",
                     hitched: false
                 )
                 */
            }
        }
    }
    
   
    func getNumberOfmyRides() -> Int {
        return myRidesArray.count
    }
    
    func getMyRide(for index:Int) -> Ride? {
        guard index < myRidesArray.count else {
            return nil
        }
        return myRidesArray[index]
    }
    
}
