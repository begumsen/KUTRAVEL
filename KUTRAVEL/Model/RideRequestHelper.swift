
import UIKit

class RideRequestHelper {
    
    var delegate: RideRequestDataDelegate?
    
    func acceptTheRideRequest (ride: RideRequest){
        
        DatabaseManager.sharedInstance.executeQuery(str: "UPDATE Hitch SET status = 1 WHERE HitchId = \(ride.hitchhikeId)")
    }
    
    func declineTheRideRequest (ride: RideRequest){
        
        DatabaseManager.sharedInstance.executeQuery(str: "UPDATE Hitch SET status = 2 WHERE HitchId = \(ride.hitchhikeId)")
    }
    
    func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }

}
