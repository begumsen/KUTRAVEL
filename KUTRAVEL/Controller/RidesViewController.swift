

import UIKit

class RidesViewController: UIViewController {
    
    var from: String = ""
    var fromNeighbourhood: String = ""
    var to: String = ""
    var toNeighbourhood: String = ""
    var date: Date = Date()
    var all: Bool = false
    
    
    private var ridesDatasource = RidesDataSource()
    private let ridesAfterSearchHelper = RidesAfterSearchHelper()
    @IBOutlet weak var ridesAfterSearchTableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = false
        // Do any additional setup after loading the view.
        ridesDatasource.delegate = self
        ridesAfterSearchHelper.delegate = self
        if(all){
            ridesDatasource.getListOfRidesWithShowAll()
        } else {
            
            ridesDatasource.getListOfRidesWithoutShowAll(to: to, toNeighbourhood: toNeighbourhood, from: from, date: date  )
        }
        
        updateTheTableViewDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        warningLabel.isHidden = true
    }
    
    
    func updateTheTableViewDesign() {
        ridesAfterSearchTableView.separatorStyle = .none
        ridesAfterSearchTableView.showsVerticalScrollIndicator = false
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
         if
             let cell = sender as? UITableViewCell,
             let indexPath = ridesAfterSearchTableView.indexPath(for: cell),
             let ride = ridesDatasource.getRide(for: indexPath.row),
             let reviewViewController = segue.destination as? MyReviewsViewController
         {
             reviewViewController.userEmail = ride.ride.mail
         }
     }
     
    
}

extension RidesViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesDatasource.getNumberOfRides()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rideAfterSearchCell", for: indexPath) as? RidesAfterSearchTableViewCell
        else{
            return UITableViewCell()
        }
        
        if var ride = ridesDatasource.getRide(for: indexPath.row){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            
            
            if(ride.ride.hitched) {
                cell.sendHitchButton.setTitle("Sent", for: .normal)
                cell.sendHitchButton.setTitleColor(.darkGray, for: .normal)
                cell.sendHitchButton.isEnabled = false
            }else{
                cell.sendHitchButton.isEnabled = true
                cell.sendHitchButton.setTitle("Send Hitch!", for: .normal)
                cell.sendHitchButton.setTitleColor(UIColor(red: 153/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1), for: .normal)
            }
            cell.fromLocationLabel.text = ride.ride.fromLocation
            cell.toLocationLabel.text = ride.ride.toLocation
            cell.dateLabel.text = dateFormatter.string(from: ride.ride.date)
            cell.fullNameLabel.text = ride.riderFullName
            cell.reviewLabel.text = "\(ridesDatasource.getRiderReviewPoint(riderEmail: ride.ride.mail))/5"
            print(ride.riderFullName)
            cell.majorLabel.text = ride.riderMajor
            cell.moneyLabel.text = "\(ride.ride.fee) TL"

            cell.hitchARideBtn = {[unowned self] in
                cell.sendHitchButton.setTitle("Sent", for: .normal)
                cell.sendHitchButton.setTitleColor(.darkGray, for: .normal)
                cell.sendHitchButton.isEnabled = false
                print("save hitch to database")
                ridesAfterSearchHelper.saveHitchToDatabase(ride: ride.ride)
                
                //ridesAfterSearchHelper.sendNotificationWithFirebase(ride: ride.ride)
                
            }
        }else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.fullNameLabel.text = "N/A"
            cell.majorLabel.text = "N/A"
            cell.moneyLabel.text = "N/A"
        }
        cell.ridesAfterSearchView.layer.cornerRadius = cell.ridesAfterSearchView.frame.height / 5
        
        
        
        
        return cell
    }
    
    
    
}

extension RidesViewController: RidesDataDelegate{
    func noDataInRides() {
        activityIndicatorView.isHidden = true
        warningLabel.isHidden = false
    }
    
    func ridesListLoaded() {
        print("RIDES LIST LOADİNG")
        activityIndicatorView.isHidden = true
        self.ridesAfterSearchTableView.reloadData()
        
    }
    
    
}

extension RidesViewController: RidesAfterSearchDelegate {
    func hitchIsSavedToFirebase() {
        
    }
}
