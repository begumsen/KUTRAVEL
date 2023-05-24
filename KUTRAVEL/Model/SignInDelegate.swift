

import Foundation

protocol SignInDelegate{
    func signInTheUser()
    func giveSignInError(errorDescription: String)
    func doNotSignInTheUser()
}
extension SignInDelegate {
    func doNotSignInTheUser(){}
}
