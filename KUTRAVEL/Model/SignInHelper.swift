import Foundation

class SignInHelper {
    
    var delegate: SignInDelegate?
    
    func checkAndSignIn (userEmail: String, userPassword: String) {
        if (userEmail == " "){
            self.delegate?.doNotSignInTheUser()
        }else {
            var responseText: String = ""
            let passwordMysql = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Password FROM User WHERE Email = '\(userEmail)'")
            if let dictionary = passwordMysql.first as? [String: String], let password = dictionary["Password"] {
                print("Password: \(password)")
                if (password == userPassword) {
                    print("password is correct")
                    self.createTheUser(userEmail: userEmail)
                }
            } else {
                print("ERROR PASSWORD")
                self.delegate?.giveSignInError(errorDescription: "password is incorrect")
            }
            
        }
       
    }
    
    
    func createTheUser (userEmail: String) {
        
        let userInfo = DatabaseManager.sharedInstance.executeQuery(str: "SELECT Email,Password,Smoking,PhoneNumber,Class,FullName,Major,Chattiness FROM User WHERE Email = '\(userEmail)'")
        print("userInfo: \(userInfo)")

        for array in userInfo {
        
            if let email = array["Email"] as? String,
               let password = array["Password"] as? String,
               let smoking = array["Smoking"] as? Int,
               let userClass = array["Class"] as? String,
               let fullName = array["FullName"] as? String,
               let major = array["Major"] as? String,
               let phone = array["PhoneNumber"] as? String,
               let chattiness = array["Chattiness"] as? Int {
                print("signing in the user")
                var user = User.sharedInstance
                user.setEmail(email: userEmail)
                user.setFullName(fullName: fullName)
                user.setMajor(major: major)
                user.setNoSmokingPreference(noSmokingPreference: (smoking != 0))
                user.setClassLevel(classLevel: userClass)
                user.setPhoneNumber(phoneNumber: phone)
                user.setSilentRidePreference(silentRidePreference: (chattiness != 0))
                let userDefault = UserDefaults.standard
                userDefault.setValue(userEmail, forKey: "userEmail")
                userDefault.setValue(password, forKey: "userPassword")
                self.delegate?.signInTheUser()
            }
        }
     
    }
    
}
