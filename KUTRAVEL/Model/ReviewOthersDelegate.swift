//
//  ReviewOthersDelegate.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 25.05.2023.
//

import Foundation


protocol ReviewOthersDelegate{
    func reviewUserListLoaded()
    func noUserToReview()
    func noReviews()
    func reviewListLoaded()
    
}
extension ReviewOthersDelegate {
    func reviewUserListLoaded(){}
    func noUserToReview(){}
    func noReviews(){}
    func reviewListLoaded(){}
}
