//
//  ReviewOthersDataSource.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import Foundation


class ReviewOthersDataSource {
    
    private var reviewUsers: [String] = []
    private var reviews: [Review] = []
    
    var delegate: ReviewOthersDelegate?
    
    init() {
    }
    
    
    func getListOfUsers(){
        
        reviewUsers.removeAll()
        let users = DatabaseManager.sharedInstance.executeQuery(str: "SELECT email, count(email) as count from User u2 Where (SELECT COUNT(*) AS HitchCount FROM Hitch h INNER JOIN Ride r ON h.RideId = r.RideId WHERE h.UserEmail = '\(User.sharedInstance.email)' AND r.UserEmail = u2.Email AND h.Status = 1) - (SELECT COUNT(*) AS ReviewCount FROM Review WHERE ReviewerMail = '\(User.sharedInstance.email)' AND ReviewedMail = u2.Email) > 0 GROUP BY email")
        
        print(users)
        print("users: \(users)")
        
        if (users.isEmpty) {
            print("users.isEmpty: \(users.isEmpty)")
            self.delegate?.noUserToReview()
        } else {
            for dict in users {
                
                if let email = dict["email"] as? String,
                   let count = dict["count"] as? Int
                {
                    
                    self.reviewUsers.append(email)
                    
                }
            }
            self.delegate?.reviewUserListLoaded()
        }
    }
    
    func getListOfReviews(){
        
        reviews.removeAll()
        let reviews = DatabaseManager.sharedInstance.executeQuery(str: "SELECT ReviewerMail, Comment, Rating FROM Review WHERE ReviewedMail = '\(User.sharedInstance.email)'")
        
        print("reviews: \(reviews)")
        
        if (reviews.isEmpty) {
            print("reviews.isEmpty: \(reviews.isEmpty)")
            self.delegate?.noReviews()
        } else {
            for dict in reviews {
                
                if let email = dict["ReviewerMail"] as? String,
                   let comment = dict["Comment"] as? String,
                   let rating = dict["Rating"] as? Int
                {
                    let review = Review(email: email, comment: comment, rating: rating)
                    self.reviews.append(review)
                    
                }
            }
            self.delegate?.reviewListLoaded()
        }
    }
    
   
    func getNumberOfUser() -> Int {
        return reviewUsers.count
    }
    
    func getUser(for index:Int) -> String? {
        guard index < reviewUsers.count else {
            return nil
        }
        return reviewUsers[index]
    }
    
    func getNumberOfReview() -> Int {
        return reviews.count
    }
    
    func getReview(for index:Int) -> Review? {
        guard index < reviews.count else {
            return nil
        }
        return reviews[index]
    }
    
}
