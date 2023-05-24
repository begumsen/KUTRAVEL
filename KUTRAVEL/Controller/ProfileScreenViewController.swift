//
//  ProfileScreenViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 31.10.2022.
//

import UIKit


class ProfileScreenViewController: UIViewController {
    
    let profileHelper = ProfileHelper()
    //let profilePictureHelper = ProfilePictureHelper()
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var gradeLevelLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var noSmokingCheckBoxImageView: UIImageView!
    
    @IBOutlet weak var silentRideCheckBoxImageView: UIImageView!
    
    @IBAction func historyOfRidesButton(_ sender: Any) {
    }
    
    @IBAction func historyOfHitchhikessButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHelper.delegate = self
        //profilePictureHelper.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileHelper.checkUserAndSetUI()
        //self.profileImageView.kf.indicatorType = .activity
        //self.profileImageView.kf.setImage(with: URL(string: User.sharedInstance.profilePictureUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.clipsToBounds = true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func signOutButtonTapped(_ sender: Any) {
        profileHelper.signOutTheUser()
    }
    
}

extension ProfileScreenViewController: ProfileDelegate{
    func signOut() {
        if let signIn: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigation") as? UINavigationController{
            view?.window?.rootViewController = signIn
        }
    }
    
    func makeProfileUIReady(user: User) {
        fullNameLabel.text = "\(user.fullName)"
        majorLabel.text = "\(user.major)"
        gradeLevelLabel.text = "\(user.classLevel)"
        phoneNumberLabel.text = "\(user.phoneNumber)"
        mailLabel.text = "\(user.email)"
        
        if user.noSmokingPreference {
            noSmokingCheckBoxImageView.image = UIImage(named: "checkedCheckbox")
        }else {
            noSmokingCheckBoxImageView.image = UIImage(named: "uncheckedCheckbox")
        }
        
        if user.chattinesFlag {
            silentRideCheckBoxImageView.image = UIImage(named: "checkedCheckbox")
        }else {
            silentRideCheckBoxImageView.image = UIImage(named: "uncheckedCheckbox")
        }
        
        
    }
    
    
    
}

