//
//  RideRequestTableViewCell.swift
//  Kuber
//
//  Created by Begum Sen on 13.12.2022.
//

import UIKit

class RideRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rideRequestView: UIView!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var gradeLevelLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var phoneLabel: UIButton!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var acceptARequestButton: (() -> ())?
    var declineARequestButton: (() -> ())?
    var phoneButtonClicked: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func phoneButtonClicked(_ sender: Any) {
        
        phoneButtonClicked?()
    }
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        
        acceptARequestButton?()
    }
    
    
    @IBAction func declineButtonClicked(_ sender: Any) {
        declineARequestButton?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
