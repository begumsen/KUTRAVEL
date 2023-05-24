
import Foundation
class ProfileHelper{
    var delegate: ProfileDelegate?
    
    func checkUserAndSetUI(){
        let user = User.sharedInstance
        
        delegate?.makeProfileUIReady(user: user)
        
    }
    
    func signOutTheUser(){
        let userDefault = UserDefaults.standard
        userDefault.setValue("", forKey: "userEmail")
        userDefault.setValue("", forKey: "userPassword")
        self.delegate?.signOut()
    }
    
}
