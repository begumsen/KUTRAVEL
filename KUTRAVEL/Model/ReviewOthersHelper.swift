//
//  ReviewOthersHelper.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import Foundation

import UIKit

class ReviewOthersHelper {
    
    var delegate: ReviewOthersDelegate?
    
    func reviewOtherUser (userEmail: String, rating: Int, comment: String){
        let result = DatabaseManager.sharedInstance.executeQuery(str: "SELECT MAX(ReviewId) As max FROM Review")
        if let dictionary = result.first as? [String: Int], let maxId = dictionary["max"] {
            let reviewId = maxId + 1
            DatabaseManager.sharedInstance.executeQuery(str: "INSERT INTO Review VALUES ('\(User.sharedInstance.email)','\(userEmail)',\(reviewId),\(rating),'\(comment)')")
        }
    }
}
