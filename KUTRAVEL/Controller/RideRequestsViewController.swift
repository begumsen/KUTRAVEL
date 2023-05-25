//
//  RideRequestsViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit


class RideRequestsViewController: UIViewController {
    
    @IBOutlet weak var rideRequestTableView: UITableView!
    private var rideRequestDatasource = RideRequestDataSource()
    var ride: Ride?
    var rideRequestHelper = RideRequestHelper()
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = false
        updateTheTableViewDesign()
        rideRequestDatasource.delegate = self
        rideRequestHelper.delegate = self
        if let ride = ride {
            rideRequestDatasource.getListOfRideRequest(ride: ride)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //warningLabel.isHidden = true
    }
    
    func updateTheTableViewDesign() {
        rideRequestTableView.separatorStyle = .none
        rideRequestTableView.showsVerticalScrollIndicator = false
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

extension RideRequestsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideRequestDatasource.getNumberOfRideRequest()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RideRequestCell") as? RideRequestTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let ride = rideRequestDatasource.getRideRequest(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            cell.nameLabel.text = ride.hitchhikerName
            cell.majorLabel.text = ride.hitchhikerMajor
            cell.gradeLevelLabel.text = ride.hitchhikerGradeLevel
            
            cell.acceptARequestButton = {[unowned self] in
                rideRequestHelper.acceptTheRideRequest(ride: ride)
                if let rideUnwrapped = self.ride{
                    print("here1")
                    cell.acceptButton.isEnabled = false
                    cell.declineButton.isEnabled = false
                    cell.phoneLabel.isEnabled = true
                    cell.acceptButton.isHidden = true
                    cell.declineButton.isHidden = true
                    cell.phoneLabel.isHidden = false
                    cell.phoneLabel.setTitle(ride.hitchhikerPhoneNumber, for: .normal)
 
                }
            }
            cell.declineARequestButton = {[unowned self] in
                rideRequestHelper.declineTheRideRequest(ride: ride)
                if let rideUnwrapped = self.ride{
                    print("here2")
                    cell.acceptButton.isEnabled = false
                    cell.declineButton.isEnabled = false
                    cell.acceptButton.setTitleColor(.darkGray, for: .disabled)
                    cell.declineButton.setTitleColor(.darkGray, for: .disabled)
                    
                   
                }
            }
            cell.phoneButtonClicked = {[unowned self] in
                rideRequestHelper.callNumber(phoneNumber: ride.hitchhikerPhoneNumber)
            }
            print(ride.status)
            if  ride.status == 2 { //declines
                cell.acceptButton.isEnabled = false
                cell.declineButton.isEnabled = false
                cell.acceptButton.setTitleColor(.darkGray, for: .disabled)
                cell.declineButton.setTitleColor(.darkGray, for: .disabled)
            }
            else if ride.status == 1 { //accepted
                cell.acceptButton.isEnabled = false
                cell.declineButton.isEnabled = false
                cell.phoneLabel.isEnabled = true
                cell.acceptButton.isHidden = true
                cell.declineButton.isHidden = true
                cell.phoneLabel.isHidden = false
                cell.phoneLabel.setTitle(ride.hitchhikerPhoneNumber, for: .normal)
            }
            
        } else {
            cell.nameLabel.text = "N/A"
            cell.majorLabel.text = "N/A"
            cell.gradeLevelLabel.text = "N/A"
        }
        cell.rideRequestView.layer.cornerRadius = cell.rideRequestView.frame.height / 5
        return cell
    }
}

extension RideRequestsViewController: RideRequestDataDelegate {
    func noDataInRideRequest() {
        print( "no data label")
        activityIndicatorView.isHidden = true
        

    }
    
    func  rideRequestListLoaded(){
        warningLabel.isHidden = true
        activityIndicatorView.isHidden = true
        self.rideRequestTableView.reloadData()
    }
}
