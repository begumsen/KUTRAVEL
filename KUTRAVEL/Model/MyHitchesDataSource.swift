
import Foundation


class MyHitchesDataSource{


    private var myHitchesArray: [Hitch] = []
    private var myFinalHitchesArray: [MyHitch] = []
    private var hitchCount: Int = 0
    var rideInfoArray: [Ride] = []
    var rideIdsUserHitched: [String] = []
    var delegate: MyHitchesDataDelegate?
    
    init() {
    }
    
    func getListOfHitches(areCurrentHitches: Bool) {
        self.myHitchesArray.removeAll()
        self.myFinalHitchesArray.removeAll()
        self.rideInfoArray.removeAll()
        var mutex = 0
        
        if (User.sharedInstance.getMyHitchesArrayCount() == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyHitches()
            }
        }
        
            let myHitches = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Hitch.*, Ride.RideId, Ride.userEmail AS riderMail, Ride.date AS rideDate, Ride.Fee, Ride.fromLoc, Ride.toLoc, Ride.NoOfSeats, USER.FullName, USER.MAJOR  FROM Hitch JOIN Ride ON Hitch.RideId = Ride.RideId INNER JOIN USER ON USER.EMAIL = Ride.userEmail WHERE Hitch.UserEmail = '\(User.sharedInstance.email)'")
        print(myHitches.count)
            
        for dict in myHitches {
            if let hitchId = dict["HitchId"] as? Int,
               let userEmail = dict["UserEmail"] as? String,
               let rideId = dict["RideId"] as? Int,
               let status = dict["Status"] as? Int,
               let date = dict["Date"] as? String,
               let fee = dict["Fee"] as? Int,
               let rideMail = dict["riderMail"] as? String,
               let rideDate = dict["rideDate"] as? String,
               let fee = dict["Fee"] as? Int,
               let fromLoc = dict["fromLoc"] as? String,
               let toLoc = dict["toLoc"] as? String,
               let noOfSeats = dict["NoOfSeats"] as? Int,
               let riderName = dict["FullName"] as? String,
               let riderMajor = dict["MAJOR"] as? String
               
               
                {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newRide =  Ride(rideId: "\(rideId)", fromLocation: fromLoc, toLocation: toLoc, date: dateFormatter.date(from: rideDate)!, seatAvailable: noOfSeats, fee: fee, mail: rideMail, hitched: false)
                let newHitch = Hitch(hitchId: "\(hitchId)", date: dateFormatter.date(from: date)!, hitchhikerMail: userEmail, rideId: "\(rideId)", status: status, ride: newRide)
                self.myHitchesArray.append(newHitch)
                print("heeeyyyyy")
                print(myHitchesArray.count)
                
                    var newMyHitch = MyHitch(
                        hitch: newHitch,
                        riderFullName: riderName,
                        riderMajor: riderMajor
                    )
                if(newMyHitch.riderFullName != User.sharedInstance.fullName){
                    self.myFinalHitchesArray.append(newMyHitch)
                    
                }
                
                
                
                
               }
           

        }
        self.myFinalHitchesArray = self.myFinalHitchesArray.sorted(by: { $0.hitch.date > $1.hitch.date })
        DispatchQueue.main.async {
            if (self.myFinalHitchesArray.count == 0){
                self.delegate?.noDataInMyHitches()
            }else{
                print("heeeyyyyy")
                print(self.myFinalHitchesArray.count)
                self.delegate?.hitchListLoaded()
            }
        }
        
    }
    
    
    func getNumberOfHitches() -> Int {
        return self.myFinalHitchesArray.count
    }
    
    func getHitch(for index: Int) -> MyHitch? {
        guard index < myFinalHitchesArray.count else {
            return nil
        }
        return myFinalHitchesArray[index]
    }
    
}


