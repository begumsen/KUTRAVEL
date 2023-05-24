
import Foundation

class ResetPasswordHelper{
    var delegate: ResetPasswordDelegate?
    
    func checkAndSend (userEmail: String, userPassword: String) {
        DatabaseManager.sharedInstance.executeQuery(str: "UPDATE User SET Password = '\(userPassword)' WHERE Email = '\(userEmail)'")
        self.delegate?.sentNavigateBack()
    }
}

