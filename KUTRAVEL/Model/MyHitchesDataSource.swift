//
//  MyHitchesDataSource.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 4.12.2022.
//

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
        
       
            /*
            var hitchId = User.sharedInstance.getMyHitchesArray()[i]
            let db = Firestore.firestore()
            let docRef2 = db.collection("hitches").document(hitchId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let dateUnwrapped = (document.get("date") as? Timestamp)?.dateValue()
                    {
                    var newHitch = Hitch (
                        hitchId: hitchId,
                        date: dateUnwrapped,
                        hitchhikerMail: document.get("hitchhikerMail") as? String ?? "",
                        rideId: document.get("rideId") as? String ?? "",
                        status: document.get("status") as? Int ?? 2,
                        ride: Ride(rideId: "", fromLocation: "",  fromNeighbourhoodLocation: "",toLocation: "",toNeighbourhoodLocation: "", date: Date(),time: Date(), seatAvailable: 0, fee: 0, mail: "", hitched: false)
                    )
                    self.myHitchesArray.append(newHitch)
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getMyHitchesArrayCount()){
                        
                        self.getRideInfo(areCurrentHitches: areCurrentHitches)
                    }
                    
                } else {
                }
                
                }  }
            
        */
       
    }
    
    func getRideInfo(areCurrentHitches: Bool) {/*
        let db = Firestore.firestore()
        var mutex = 0
        if (myHitchesArray.count == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyHitches()
            }
        } else{
            for i in 0..<myHitchesArray.count {
                var hitch = myHitchesArray[i]
                var rideId = hitch.rideId
                let docRef2 = db.collection("rides").document(rideId)
                docRef2.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let dateUnwrapped = (document.get("date") as? Timestamp)?.dateValue(),
                           let timeUnwrapped = (document.get("time") as? Timestamp)?.dateValue()
                        {
                        var ride = Ride (
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
                        self.myHitchesArray[i].ride = ride
                        mutex = mutex + 1
                        if (mutex == self.myHitchesArray.count){
                            self.getRiderInfo(areCurrentHitches: areCurrentHitches)
                        }
                    }}
                }
            }
        }
    */}
    
    func getRiderInfo(areCurrentHitches: Bool){/*
        let db = Firestore.firestore()
        self.myFinalHitchesArray.removeAll()
        var mutex = 0
        for i in 0..<myHitchesArray.count {
            var hitch = myHitchesArray[i]
            var riderMail = hitch.ride.mail
            let docRef2 = db.collection("users").document(riderMail)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newMyHitch = MyHitch(
                        hitch: hitch,
                        riderFullName: document.get("fullName") as? String ?? "",
                        riderMajor: document.get("major") as? String ?? "",
                        riderProfileImageUrl: document.get("profileImageUrl") as? String ?? "",
                        riderProfileImageData: Data()
                    )
                    self.myFinalHitchesArray.append(newMyHitch)
                    mutex = mutex + 1
                    if (mutex == self.myHitchesArray.count){
                        DispatchQueue.main.async {
                            self.isAlreadyHitched()
                            // Displaying the current (not expired/old) hitchhikes of the user in the table view
                            // The filtering is dependent on the ride's original date that the hitchhiker has requested
                            self.myFinalHitchesArray = self.myFinalHitchesArray.filter{(myHitch) -> Bool in
                                let date1 = myHitch.hitch.ride.date // for day, month, year, we look at ride.date
                                let date2 = myHitch.hitch.ride.time // for hour, minute, second, we look at ride.time
                                
                                // Therefore, we need to extract the components from the two dates
                                let date1Components = Calendar.current.dateComponents([.day, .month, .year], from: date1)
                                let date2Components = Calendar.current.dateComponents([.hour, .minute, .second], from: date2)
                                
                                // Create the date value that the user has selected for the ride
                                // by combining the components from the two dates
                                if let realDateOfRide = Calendar.current.date(from: DateComponents(year: date1Components.year, month: date1Components.month, day: date1Components.day, hour: date2Components.hour, minute: date2Components.minute, second: date2Components.second)){
                                    
                                    if areCurrentHitches {
                                        // My Hitches Screen would have areCurrentHitches: true
                                        // The current hitches would be displayed
                                        return realDateOfRide >= Date()
                                    } else {
                                        // History of Hitchhikes Screen would have areCurrentHitches: false
                                        // The old hitches would be displayed
                                        return realDateOfRide < Date()
                                    }
                                    
                                }else {
                                    return false
                                }
                                
                            }
                            
                            self.myFinalHitchesArray = self.myFinalHitchesArray.sorted(by: { $0.hitch.date > $1.hitch.date })
                            DispatchQueue.main.async {
                                if (self.myFinalHitchesArray.count == 0){
                                    self.delegate?.noDataInMyHitches()
                                }else{
                                    self.delegate?.hitchListLoaded()
                                }
                            }
                        }
                    }
                    
                } else {
                }
                
            }
            
        }
            
    */}
    
    func isAlreadyHitched (){/*
        var mutex = 0
        rideIdsUserHitched.removeAll()
        for hitches in User.sharedInstance.getMyHitchesArray(){
            let db = Firestore.firestore()
            let docRef2 = db.collection("hitches").document(hitches)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var rideId=""
                    if let rideIdUnwrapped = document.get("rideId") as? String{
                        rideId=rideIdUnwrapped
                    }
                    self.rideIdsUserHitched.append(rideId)
                    mutex = mutex + 1
                    if(mutex == User.sharedInstance.getMyHitchesArray().count){
                        User.sharedInstance.setMyHitchesToRideIdArray(rideIds: self.rideIdsUserHitched)
                    }
                }
            }
        }
        
    */}
    
    
    
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


