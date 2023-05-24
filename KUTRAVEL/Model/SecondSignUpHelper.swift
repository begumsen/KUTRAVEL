
import Foundation
import UIKit


class SecondSignUpHelper{
    var delegate: SecondSignUpDelegate?
    
    var user = User.sharedInstance
    
    init() {
    }
    
    func signUp(fullName: String, phoneNumber: String, major:String, segmentIndex:Int, noSmokingFlag: Bool, silentRideFlag: Bool, userEmail: String, userPassword: String) {
        
        var chattiness = 0
        if(silentRideFlag) {
            chattiness = 1
        }
        var smoking = 0
        if(noSmokingFlag) {
            smoking = 1
        }
        
        var classLevel: String = ""
        if segmentIndex==0 {
            classLevel = "ELC"
        }
        if segmentIndex==1 {
            classLevel = "Freshman"
        }
        if segmentIndex==2 {
            classLevel = "Sophomore"
        }
        if segmentIndex==3 {
            classLevel = "Junior"
        }
        if segmentIndex==4 {
            classLevel = "Senior"
        }
        
        DatabaseManager.sharedInstance.executeQuery(str: "INSERT INTO User VALUES ('\(userEmail)','\(fullName)','\(major)','\(classLevel)',\(chattiness),\(smoking),'\(userPassword)','\(phoneNumber)')")
        print("INSERT INTO User VALUES ('\(userEmail)','\(fullName)','\(major)','\(classLevel)',\(chattiness),\(smoking),'\(userPassword)','\(phoneNumber)')")
        self.delegate?.makeFieldsEmpty()
        
    }
    
   
    func setCurrentMajorAsChosen(actionTitle: String? = nil, menu: UIMenu) -> UIMenu {
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        return menu
    }
    
}
