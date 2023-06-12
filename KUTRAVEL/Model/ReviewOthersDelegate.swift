
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
