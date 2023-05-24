//
//  myRidesViewController.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
//

import UIKit

class MyRidesViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var myRidesTableView: UITableView!
    
    
    @IBOutlet weak var addButton: UIButton!
    private var myRidesDatasource = MyRidesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.imageView?.contentMode = .scaleAspectFit
        myRidesDatasource.delegate = self
        updateTheTableViewDesign()
        // Do any additional setup after loading the view.
        
    }
    
    func updateTheTableViewDesign() {
        myRidesTableView.separatorStyle = .none
        myRidesTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        warningLabel.isHidden = true
        myRidesDatasource.getListOfMyRides()
        print("getListOfMyRides()")
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //AÇ
        /*if
            let cell = sender as? UITableViewCell,
            let indexPath = myRidesTableView.indexPath(for: cell),
            let myRide = myRidesDatasource.getMyRide(for: indexPath.row),
            let rideRequestController = segue.destination as? RideRequestsViewController
        {
            rideRequestController.ride = myRide
        }*/
    }
    
    
}

extension MyRidesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRidesDatasource.getNumberOfmyRides()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyRideCell") as? RideListTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let ride = myRidesDatasource.getMyRide(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.fromLocationLabel.text = ride.fromLocation
            cell.toLocationLabel.text = ride.toLocation
            cell.availableSeatLabel.text = "\(ride.seatAvailable)"
            cell.dateLabel.text = dateFormatter.string(from: ride.date)
            cell.feeLabel.text = "\(ride.fee) TL"
        } else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.availableSeatLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.feeLabel.text = "N/A"
        }
        cell.myRideView.layer.cornerRadius = cell.myRideView.frame.height / 5
        
        return cell
    }
}



extension MyRidesViewController: MyRidesDataDelegate {
    func noDataInMyRides() {
        warningLabel.isHidden = false
    }
    
    func myRidesListLoaded(){
        self.myRidesTableView.reloadData()
        
    }
}
