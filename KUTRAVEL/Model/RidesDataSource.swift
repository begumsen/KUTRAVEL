
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
        
        let rides = DatabaseManager.sharedInstance.executeQuery(str: "SELECT * FROM Ride INNER JOIN User ON User.email = Ride.userEmail WHERE Ride.date > CURDATE()")
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
                if(User.sharedInstance.fullName != fullName){
                    self.rideSearchArray.append(newRideSearch)
                }
               }
        }
        
        print(self.rideSearchArray)
        self.delegate?.ridesListLoaded()
        

        
        /*
        self.ridesArray.removeAll()
        var mutex = 0
        let db = Firestore.firestore()

        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
            } else {
                if let snapshotCount = querySnapshot?.count{
                    self.rideCount = snapshotCount
                }
                if let snapshotDocument = querySnapshot?.documents {
                    
                    for document in snapshotDocument {
                        if let datee = (document.get("date") as? Timestamp)?.dateValue(),
                           let timee = (document.get("time") as? Timestamp)?.dateValue()
                        {
                            
                            var newRide = Ride (
                                rideId: document.documentID,
                                fromLocation: document.get("from") as? String ?? "",
                                fromNeighbourhoodLocation: document.get("fromNeighbourhood") as? String ?? "",
                                toLocation: document.get("to") as? String ?? "",
                                toNeighbourhoodLocation: document.get("toNeighbourhood") as? String ?? "",
                                date: datee,
                                time: timee,
                                seatAvailable: document.get("numberOfSeats") as? Int ?? 1,
                                fee: document.get("fee") as? Int ?? 0,
                                mail: document.get("mail") as? String ?? "",
                                hitched: User.sharedInstance.getMyHitchesToRideIdArray().contains(document.documentID)
                            )
                            
                            self.ridesArray.append(newRide)
                            self.ridesArray = self.ridesArray.filter{ $0.mail != User.sharedInstance.getEmail() }
                            self.ridesArray = self.ridesArray.filter{(ride) -> Bool in
                                let date1 = ride.date // for day, month, year, we look at ride.date
                                let date2 = ride.time // for hour, minute, second, we look at ride.time
                                
                                // Therefore, we need to extract the components from the two dates
                                let date1Components = Calendar.current.dateComponents([.day, .month, .year], from: date1)
                                let date2Components = Calendar.current.dateComponents([.hour, .minute, .second], from: date2)

                                // Create the date value that the user has selected for the ride
                                // by combining the components from the two dates
                                if let realDateOfRide = Calendar.current.date(from: DateComponents(year: date1Components.year, month: date1Components.month, day: date1Components.day, hour: date2Components.hour, minute: date2Components.minute, second: date2Components.second)){
                                  
                                    return Calendar.current.compare(Date.now, to: realDateOfRide, toGranularity: .minute) == .orderedSame || Calendar.current.compare(Date.now, to: realDateOfRide, toGranularity: .minute) == .orderedAscending
                                }else {
                                    // not a valid date
                                    return false
                                }

                            }






                            self.ridesArray = self.ridesArray.sorted{ $0.date <  $1.date }
                            mutex = mutex + 1
                            if (mutex == self.rideCount){
                                DispatchQueue.main.async {
                                    self.getRiderInfo()
                                }
                            }
                        } }}
            }
        }
    */}
    
    
    func getListOfRidesWithoutShowAll(to: String, toNeighbourhood: String, from: String, date: Date, time: Date ) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
        let rides = DatabaseManager.sharedInstance.executeQuery(str: "SELECT * FROM Ride inner join user on user.email = ride.useremail WHERE ride.fromloc = '\(from)' AND RIDE.TOLOC = '\(to)' AND RIDE.DATE =  '\(dateString)' ")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for dict in rides {
            if let rideId = dict["RideId"] as? Int,
               let userEmail = dict["UserEmail"] as? String,
               let fullName = dict["FullName"] as? String,
               let major = dict["Major"] as? String,
               let date = dict["Date"] as? String,
               let fee = dict["Fee"] as? Int,
               let fromLoc = dict["FromLoc"] as? String,
               let toLoc = dict["ToLoc"] as? String,
               let noOfSeats = dict["NoOfSeats"] as? Int {
                let newRide = Ride(rideId: "\(rideId)", fromLocation: fromLoc, toLocation: toLoc, date: dateFormatter.date(from: date)!, seatAvailable: noOfSeats, fee: fee, mail: userEmail, hitched: false)
                self.ridesArray.append(newRide)
                print("ride:")
                print(newRide)
                print("ride appended")
                var newRideSearch = RideSearch(
                    ride: newRide,
                    riderFullName: fullName,
                    riderMajor: major
                )
                self.rideSearchArray.append(newRideSearch)
               }
        }
        
        print(self.rideSearchArray)
        self.delegate?.ridesListLoaded()
        
        
        /*
        
        var mutex = 0
        self.ridesArray.removeAll()
        let db = Firestore.firestore()

        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
            } else {
                    
                     if let snapshotCount = querySnapshot?.count{
                         self.rideCount = snapshotCount
                     }
                     if let snapshotDocument = querySnapshot?.documents {
             
                     for document in snapshotDocument {
                         
                         var newRide = Ride (
                             rideId: document.documentID,
                             fromLocation: document.get("from") as? String ?? "",
                             fromNeighbourhoodLocation: document.get("fromNeighbourhood") as? String ?? "",
                             toLocation: document.get("to") as? String ?? "",
                             toNeighbourhoodLocation: document.get("toNeighbourhood") as? String ?? "",
                             date: (document.get("date") as? Timestamp)?.dateValue() ??  Date(),
                             time: (document.get("time") as? Timestamp)?.dateValue() ??  Date(),
                             seatAvailable: document.get("numberOfSeats") as? Int ?? 1,
                             fee: document.get("fee") as? Int ?? 0,
                             mail: document.get("mail") as? String ?? "",
                             hitched: User.sharedInstance.getMyHitchesToRideIdArray().contains(document.documentID)
                         )
                     
                    
                    self.ridesArray.append(newRide)
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            self.sortTheRideArray( to: to , toNeighbourhood: toNeighbourhood ,hitchhikerFrom: from, date: date , time: time  )
                            //self.delegate?.ridesListLoaded()
                            //self.getRiderInfo()
                        }
                    }
                     }   }
            }
        }
        
        /*var fromTown = "Atasehir"//ilçe
        var fromNeighbourhood = "Barbaros" //Mahalle
        var toTown = "Sariyer"//ilçe
        var toNeighbourhood = "Darussafaka" //Mahalle
        /* Adres template
         https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Zekeriyaköy%2CSarıyer&origins=Darüşşafaka%2CSarıyer&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34
         */
        
        var finalUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=" + toNeighbourhood + "%2C" + toTown + "%7CIstanbul%2CTurkiye&origins=" + fromNeighbourhood + "%2C" + fromTown + "%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Asik%2CVeysel%2CAtasehir%7CIstanbul%2CTurkiye&origins=Darussafaka%2CSariyer%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
        var resp = ""
        URLSession.shared.dataTask(with: NSURL(string: finalUrl)! as URL) { data, response, error in
            resp = String( data:data!, encoding:String.Encoding(rawValue: NSUTF8StringEncoding) )!
            print(resp)
            var flag = 0
            var index = 0
            var distance = ""
            for char in resp {
                if (flag >= 4){
                    if (flag >= 9){
                        if(char == " "){
                            break
                        }
                        if(char==","){
                            distance = distance + "."
                        } else {
                            distance = distance + String(char)
                        }
                        
                    }
                    flag = flag + 1
                }
                if (char == "t" && flag == 0){
                    flag = flag+1
                }
                 else if (flag == 1){
                    print("flag is one")
                    print(char)
                    if(char == "e"){
                        flag = flag+1
                        print("e found")
                        print(flag)
                    } else {
                        flag = 0
                    }
                }
                else if (flag == 2){
                    if(char == "x"){
                        flag = flag+1
                        print("x found")
                        print(flag)
                    } else {
                        flag = 0
                    }
                }
                else if (flag == 3){
                    if(char == "t"){
                        flag = flag+1
                        print("t found")
                        print(flag)
                    } else {
                        flag = 0
                    }
                }
                
                
            }
            let numberFormatter = NumberFormatter()
            let number = numberFormatter.number(from: distance)
            let numberFloatValue = number?.floatValue
            print("FOUND DISTANCE")
            print( (numberFloatValue as! Float)+2)
            
            
        }.resume()*/
        
       
        
   */ }
    
    func getRiderInfo (){/*
        if(ridesArray.count == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInRides()
            }
        }
        rideSearchArray.removeAll()
        rideSearchArray = [RideSearch?](repeating: nil, count: ridesArray.count)
        let db = Firestore.firestore()
        var mutex = 0
        for i in 0..<ridesArray.count {
            var ride = ridesArray[i]
            var riderMail = ride.mail
            let docRef2 = db.collection("users").document(riderMail)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRideSearch = RideSearch(
                        ride: ride,
                        riderFullName: document.get("fullName") as? String ?? "",
                        riderMajor: document.get("major") as? String ?? "",
                        profileImageUrl: document.get("profileImageUrl") as? String ?? "",
                        profileImageData: Data()
                    )
                    self.rideSearchArray[i] = newRideSearch
                    mutex = mutex + 1
                    if (mutex == self.ridesArray.count){
                        DispatchQueue.main.async {
                            self.delegate?.ridesListLoaded()
                        }
                    }
                    
                } else {
                }
                
            }
            
        }
    */}
    
    
    
    func getNumberOfRides() -> Int {
        return rideSearchArray.count
    }
    
    func getRide(for index: Int) -> RideSearch? {
        guard index < rideSearchArray.count else {
            return nil
        }
        return rideSearchArray[index]
    }
    
    
    func sortTheRideArray( to: String, toNeighbourhood: String, hitchhikerFrom: String, date: Date, time: Date  ){/*
        var ridePointDictionary = [Ride: Double]()
        var sortedRidesArray: [Ride] = []
        var sortedArrayCounter = 0
       var counter = 0
        self.ridesArray = self.ridesArray.filter{ $0.mail != User.sharedInstance.getEmail() }
        for var ride in self.ridesArray{
            let db = Firestore.firestore()
            
            var ridePoint = 0.0
            let docRef = db.collection("users").document(ride.mail)
            var riderNoSmokingPreference = false
            var riderSilentRidePreference = false
            var riderClassLevel = ""
            var riderSmokeMatch = false
            var riderChatMatch = false
            var ridersMatch = false
            var riderMajor = ""
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
          
                   if let riderNoSmoke = document.get("smokingFlag") as? Bool {
                       riderNoSmokingPreference = riderNoSmoke
                   }
                   if let riderSilent = document.get("chattinessFlag") as? Bool {
                       riderSilentRidePreference = riderSilent
                   }
                   if let classLev = document.get("classLevel") as? String {
                       riderClassLevel = classLev
                   }
                   if let rideMajor = document.get("major") as? String {
                       riderMajor = rideMajor
                   }

                   if (riderNoSmokingPreference == User.sharedInstance.getNoSmokingPreference()){
                            riderSmokeMatch = true
                    }
                    if (riderSilentRidePreference == User.sharedInstance.getSilentRidePreference()){
                            riderChatMatch = true
                    }
                    if (riderSmokeMatch == true) && (riderChatMatch == true){
                            ridersMatch = true
                    }
                   
                   var hitchhikerToTown = to//ilçe
                   var hitchhikerToNeighbourhood = toNeighbourhood //Mahalle
   
                   var riderToTown = ride.toLocation//ilçe
                   var riderToNeighbourhood = ride.toNeighbourhoodLocation //Mahalle
                   if(riderToNeighbourhood == "Ana Kampüs"){
                       riderToTown = "Sarıyer"
                       riderToNeighbourhood = "Koç Üniversitesi"
                   } else if (riderToNeighbourhood == "Batı Kampüs"){
                       riderToTown = "Sarıyer"
                       riderToNeighbourhood = "Yediveren Sokak"
                   }
                   if(toNeighbourhood == "Ana Kampüs"){
                       hitchhikerToTown = "Sarıyer"
                       hitchhikerToNeighbourhood = "Koç Üniversitesi"
                   } else if (toNeighbourhood == "Batı Kampüs"){
                       hitchhikerToTown = "Sarıyer"
                       hitchhikerToNeighbourhood = "Yediveren Sokak"
                   }
                   hitchhikerToTown = self.parseAddress(address: hitchhikerToTown)
                   hitchhikerToNeighbourhood = self.parseAddress(address: hitchhikerToNeighbourhood)
                   riderToTown = self.parseAddress(address: riderToTown)
                   riderToNeighbourhood = self.parseAddress(address: riderToNeighbourhood)
                   
                   /* Adres template
                    https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Zekeriyaköy%2CSarıyer&origins=Darüşşafaka%2CSarıyer&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34
                    */
                   
                   var finalUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=" + riderToNeighbourhood + "%2C" + riderToTown + "%7CIstanbul%2CTurkiye&origins=" + hitchhikerToNeighbourhood + "%2C" + hitchhikerToTown + "%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
                   
                   let url = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Asik%2CVeysel%2CAtasehir%7CIstanbul%2CTurkiye&origins=Darussafaka%2CSariyer%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
                   var resp = ""
                   var result = 0.0
                   URLSession.shared.dataTask(with: NSURL(string: finalUrl)! as URL) { data, response, error in
                       resp = String( data:data!, encoding:String.Encoding(rawValue: NSUTF8StringEncoding) )!
                       var flag = 0
                       var index = 0
                       var distance = ""
                       for char in resp {
                           if (flag >= 4){
                               if (flag >= 9){
                                   if(char == " "){
                                       break
                                   }
                                   if(char==","){
                                       distance = distance + "."
                                   } else {
                                       distance = distance + String(char)
                                   }
                                   
                               }
                               flag = flag + 1
                           }
                           if (char == "t" && flag == 0){
                               flag = flag+1
                           }
                            else if (flag == 1){
                               
                               if(char == "e"){
                                   flag = flag+1
                                   

                               } else {
                                   flag = 0
                               }
                           }
                           else if (flag == 2){
                               if(char == "x"){
                                   flag = flag+1
                                   

                               } else {
                                   flag = 0
                               }
                           }
                           else if (flag == 3){
                               if(char == "t"){
                                   flag = flag+1
                                   

                               } else {
                                   flag = 0
                               }
                           }
                           
                           

                       }
                       let numberFormatter = NumberFormatter()
                       let number = numberFormatter.number(from: distance)
                       let numberFloatValue = number?.floatValue
                       var distanceBetweenDestinations = numberFloatValue
                       var riderClassLevelInt = 0
                        if (riderClassLevel == "ELC"){
                                riderClassLevelInt = 0
                        }
                        if (riderClassLevel == "Freshman"){
                                riderClassLevelInt = 1
                        }
                        if (riderClassLevel == "Sophomore"){
                                riderClassLevelInt = 2
                        }
                        if (riderClassLevel == "Junior"){
                                riderClassLevelInt = 3
                        }
                        if (riderClassLevel == "Senior"){
                                riderClassLevelInt = 4
                        }
                       var userClassLevelInt = 0
                                              
                        if (User.sharedInstance.getClassLevel() == "ELC"){
                                userClassLevelInt = 0
                        }
                        if (User.sharedInstance.getClassLevel() == "Freshman"){
                                    userClassLevelInt = 1
                        }
                        if (User.sharedInstance.getClassLevel() == "Sophomore"){
                                    userClassLevelInt = 2
                        }
                        if (User.sharedInstance.getClassLevel() == "Junior"){
                                    userClassLevelInt = 3
                        }
                            if (User.sharedInstance.getClassLevel() == "Senior"){
                                    userClassLevelInt = 4
                            }
                                              
                       var classDifference = abs(userClassLevelInt-riderClassLevelInt)
                       if let numberFloatValue=numberFloatValue{
                           ridePoint = ridePoint - Double(numberFloatValue)
                       }
                       ridePoint = ridePoint - Double(classDifference)
                       ridePoint = ridePoint - (Double(ride.fee)/5)
                       /*let rideTime = ride.time
                       var calendar = Calendar.current
                       let hour = calendar.component(.hour, from: rideTime)
                       let minute = calendar.component(.minute, from: rideTime)*/
                       var calendar = Calendar.current
                       var hitcherDateSelectionDay = calendar.component(.day, from: date)
                       var hitcherDateSelectionMonth = calendar.component(.month, from: date)
                       var hitcherDateSelectionYear = calendar.component(.year, from: date)
                       var hitcherHourSelection = calendar.component(.hour, from: time)
                       var hitcherMinuteSelection = calendar.component(.minute, from: time)
                       var rideDateYear = calendar.component(.year, from: ride.date)
                       var rideDateMonth = calendar.component(.month, from: ride.date)
                       var rideDateDay = calendar.component(.day, from: ride.date)
                       var rideTimeHour = calendar.component(.hour, from: ride.time)
                       var rideTimeMinute = calendar.component(.minute, from: ride.time)

                       
                       var rideTime = ride.time
                       if let distanceBetweenDestinations=distanceBetweenDestinations{
                           ridePoint = ridePoint - Double(distanceBetweenDestinations)
                       }
                       var timeDifferenceHour = rideTimeHour - hitcherHourSelection
                       var timeDifferenceMinute = rideTimeMinute - hitcherMinuteSelection
                       var timeDifferenceInMinutes = abs(60*timeDifferenceHour+timeDifferenceMinute)
                       ridePoint = ridePoint - Double(timeDifferenceInMinutes*10)
                       if(riderMajor == User.sharedInstance.getMajor()){
                           ridePoint = ridePoint + 2
                       }
                       if(rideDateDay == hitcherDateSelectionDay ) && (rideDateMonth == hitcherDateSelectionMonth ) && (rideDateYear == hitcherDateSelectionYear )  {
                           ridePointDictionary[ride] = ridePoint
                       }
                       
                       var sortedByValueDictionary = ridePointDictionary.sorted { $0.1 > $1.1 }
                       
                       /*sortedByValueDictionary = sortedByValueDictionary.filter{ $0 != $1  }
                       print(sortedByValueDictionary)*/
                       counter = counter + 1
                       
                       if(counter == self.ridesArray.count){
                           for (rideKey , ridePoint2 ) in sortedByValueDictionary {
                               var rideFromTownComparisonString = rideKey.fromLocation
                               var hitchhikerFromComparisonString = hitchhikerFrom
                               if (rideFromTownComparisonString == "Koç Üniversitesi" || rideFromTownComparisonString == "Koç Üniversitesi Kampüsleri"){
                                   rideFromTownComparisonString = "Sarıyer"
                               }
                               if(hitchhikerFromComparisonString == "Koç Üniversitesi" || hitchhikerFromComparisonString == "Koç Üniversitesi Kampüsleri"){
                                   hitchhikerFromComparisonString = "Sarıyer"
                               }
                              
                               if((sortedArrayCounter < 5)&&(!sortedRidesArray.contains(rideKey))&&(rideFromTownComparisonString == hitchhikerFromComparisonString))/*&&ridersMatch*/{
                                   
                                   sortedRidesArray.append(rideKey)
                                   sortedArrayCounter = sortedArrayCounter + 1
                               }
                           }
                           sortedRidesArray = sortedRidesArray.filter{(ride) -> Bool in
                               let date1 = ride.date // for day, month, year, we look at ride.date
                               let date2 = ride.time // for hour, minute, second, we look at ride.time
                               
                               // Therefore, we need to extract the components from the two dates
                               let date1Components = Calendar.current.dateComponents([.day, .month, .year], from: date1)
                               let date2Components = Calendar.current.dateComponents([.hour, .minute, .second], from: date2)

                               // Create the date value that the user has selected for the ride
                               // by combining the components from the two dates
                               if let realDateOfRide = Calendar.current.date(from: DateComponents(year: date1Components.year, month: date1Components.month, day: date1Components.day, hour: date2Components.hour, minute: date2Components.minute, second: date2Components.second)){
                                 
                                   return Calendar.current.compare(Date.now, to: realDateOfRide, toGranularity: .minute) == .orderedSame || Calendar.current.compare(Date.now, to: realDateOfRide, toGranularity: .minute) == .orderedAscending
                               }else {
                                   // not a valid date
                                   return false
                               }

                           }
                           self.ridesArray = sortedRidesArray
                           //self.delegate?.ridesListLoaded()
                           self.getRiderInfo()
                       }
                       
                       
                      

                   }.resume()
                   
               } else {
                   
               }
           }
            
        }
    */}
    
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
//commit
