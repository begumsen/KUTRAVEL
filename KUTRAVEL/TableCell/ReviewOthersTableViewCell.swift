
import UIKit

class ReviewOthersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    
    @IBOutlet weak var ratingTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    

    var sendAReviewButton: (() -> ())?
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        
        sendAReviewButton?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
