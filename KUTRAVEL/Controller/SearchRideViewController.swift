
import UIKit

class SearchRideViewController: UIViewController {
    
    
    
    @IBOutlet weak var fromLocation: UIButton!
    @IBOutlet weak var toLocation: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showAllSwitch: UISwitch!
    @IBOutlet weak var showAllLabel: UILabel!
    private let kuTravelDataSource=KuTravelDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAllLabel.tag = 001
        setFromLocationPopUpButton()
        setToLocationPopUpButton()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromLocation.setTitle("From (District)", for: .normal)
         toLocation.setTitle("To (District)", for: .normal)
        
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
    }
    
    func setFromLocationPopUpButton(){
        let number=kuTravelDataSource.getNumberDistricts()
        let optionClosure = {(action: UIAction) in
            self.fromLocation.setTitle(action.title, for: .normal)
            
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 1{
                children[i]=UIAction(title: kuTravelDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuTravelDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        fromLocation.menu=UIMenu(children:children)
        fromLocation.showsMenuAsPrimaryAction=true
        fromLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setToLocationPopUpButton(){
        let number=kuTravelDataSource.getNumberDistricts()
        let optionClosure = {(action: UIAction) in
            self.toLocation.setTitle(action.title, for: .normal)
            
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 1{
                children[i]=UIAction(title: kuTravelDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuTravelDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        toLocation.menu=UIMenu(children:children)
        toLocation.showsMenuAsPrimaryAction=true
        toLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    
   
    
   
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let ridesViewController = segue.destination as? RidesViewController{
            if let from = fromLocation.currentTitle {
                ridesViewController.from = from
            }
            
            if let to = toLocation.currentTitle {
                ridesViewController.to = to
            }
            
            let date = datePicker.date
            let all = showAllSwitch.isOn
            
            ridesViewController.date = date
            ridesViewController.all = all
        }
    }
    
}







