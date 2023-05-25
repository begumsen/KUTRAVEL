//
//  ReviewOthersViewController.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import UIKit

class ReviewOthersViewController: UIViewController {

    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    let reviewOthersDataSource = ReviewOthersDataSource()
    let reviewOthersHelper = ReviewOthersHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewOthersDataSource.delegate = self
        reviewOthersHelper.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        reviewOthersDataSource.getListOfUsers()
        print("getListOfUsers()")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReviewOthersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewOthersDataSource.getNumberOfUser()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewOtherCell") as? ReviewOthersTableViewCell
        else  {
            
            return UITableViewCell()
        }
        if let userName = reviewOthersDataSource.getUser(for: indexPath.row){
            cell.fullNameLabel.text = userName
            
            cell.sendAReviewButton = {[unowned self] in
                
                if let text = cell.ratingTextField.text, let intValue = Int(text){
                    reviewOthersHelper.reviewOtherUser(userEmail: userName, rating: intValue, comment: cell.commentTextField.text ?? "No comment")
                        cell.sendButton.isEnabled = false
                } else {
                    print("wrong input")
                }

            }
        } else {
            cell.fullNameLabel.text = "userName"
        }
        return cell
    }
}

extension ReviewOthersViewController: ReviewOthersDelegate {
    
    func reviewUserListLoaded() {
        warningLabel.isHidden = true
        self.reviewTableView.reloadData()
    }
    
    func noUserToReview() {
        warningLabel.isHidden = false
    }
}
