

class SignUpHelper{
    var delegate: SignUpDelegate?
    
    init() {
    }

    func createAndSaveUser(email:String,password:String){
        
        
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT COUNT(*) As count FROM User WHERE email = '\(email)'")
        if let dictionary = result.first as? [String: Int], let exist = dictionary["count"] {
            print(exist)
            if (exist != 0) {
                print("email already exist")
                self.delegate?.giveSignUpError(errorDescription: "You have already signed up")
            }
            else {
                
                self.delegate?.signUpTheUser()
                
            }
            
        }
        
    }
    
}



