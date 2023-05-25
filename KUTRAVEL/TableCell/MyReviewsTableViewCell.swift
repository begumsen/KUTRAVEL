//
//  MyReviewsTableViewCell.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import UIKit

class MyReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
