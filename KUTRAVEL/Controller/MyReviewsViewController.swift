//
//  MyReviewsViewController.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import UIKit

class MyReviewsViewController: UIViewController {

    
    @IBOutlet weak var myReviewsTableView: UITableView!
    
    let reviewOthersDataSource = ReviewOthersDataSource()
   
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewOthersDataSource.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reviewOthersDataSource.getListOfReviews()
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

extension MyReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewOthersDataSource.getNumberOfReview()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewCell") as? MyReviewsTableViewCell
        else  {
            
            return UITableViewCell()
        }
        if let review = reviewOthersDataSource.getReview(for: indexPath.row){
            cell.emailLabel.text = review.email
            cell.commentLabel.text = review.comment
            cell.ratingLabel.text = " \(review.rating) / 5"
            
        
        } else {
            
        }
        return cell
    }
}

extension MyReviewsViewController: ReviewOthersDelegate {
    
    func reviewListLoaded() {
        warningLabel.isHidden = true
        self.myReviewsTableView.reloadData()
    }
    
    func noReviews() {
        warningLabel.isHidden = false
    }
}
