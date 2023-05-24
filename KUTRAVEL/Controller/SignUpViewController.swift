//
//  SignUpViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import UIKit


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var errorText: UILabel!
    let signUpHelper = SignUpHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // passwordField.isSecureTextEntry=true
        signUpHelper.delegate = self
        //emailField.delegate = self
        //passwordField.delegate = self
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func continueButtonIsClicked(_ sender: Any) {
        if let email = emailField.text,
           let password = passwordField.text{
            
            signUpHelper.createAndSaveUser(email:email,password:password)
            
        }
        
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let  profileImageView = profileImageView , let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 100 - keyboardSize.height
        profileImageView.isHidden=true

        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
        profileImageView.isHidden=false
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     if let secondSignUpViewController = segue.destination as? SecondSignUpViewController{
     secondSignUpViewController.userEmail = emailField.text!
     }
     }
     */
}
extension SignUpViewController: SignUpDelegate {
    func signUpTheUser() {
        // if the user's email and password is validated
        // the user will be signed up and navigated to next screen
        if let email = emailField.text {
            //signUpHelper.setImageUrl(email: email, imageData: self.imageData)
        }
        if let secondSignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpViewController") as? SecondSignUpViewController,
           let emailTextUnwrapped = self.emailField.text,
           let passwordTextUnwrapped = self.passwordField.text {
            secondSignUpViewController.userEmail = emailTextUnwrapped
            secondSignUpViewController.userPassword = passwordTextUnwrapped
            self.navigationController?.pushViewController(secondSignUpViewController, animated:true)
        }
        errorText.text = ""
        passwordField.text = ""
        emailField.text = ""
    }
    
    func giveSignUpError( errorDescription: String) {
        errorText.text = errorDescription
        errorText.isHidden = false
        errorText.textColor = UIColor.red
        errorText.adjustsFontSizeToFitWidth = true
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



extension SignUpViewController: UINavigationControllerDelegate{
    
}
