
import UIKit

class SearchRideViewController: UIViewController {
    
    // @IBOutlet weak var toLocation: UITextField!
    //@IBOutlet weak var fromLocation: UITextField!
    
    @IBOutlet weak var fromLocation: UIButton!
    @IBOutlet weak var fromNeighbourhoodLocation: UIButton!
    @IBOutlet weak var toLocation: UIButton!
    @IBOutlet weak var toNeighbourhoodLocation: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showAllSwitch: UISwitch!
    @IBOutlet weak var showAllLabel: UILabel!
    private let kuTravelDataSource=KuTravelDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAllLabel.tag = 001
        //kuberDataSource.getListOfDistricts()
        setFromLocationPopUpButton()
        setToLocationPopUpButton()
        setDefaultFromNeighbourhoodLocationPopUpButton()
        setDefaultToNeighbourhoodLocationPopUpButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromLocation.setTitle("From (District)", for: .normal)
        fromNeighbourhoodLocation.setTitle("From (Neighbourhood)", for: .normal)
        toLocation.setTitle("To (District)", for: .normal)
        toNeighbourhoodLocation.setTitle("To (Neighbourhood)", for: .normal)
        
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
    }
    
    func setFromLocationPopUpButton(){
        let number=kuTravelDataSource.getNumberDistricts()
        let optionClosure = {(action: UIAction) in
            self.fromLocation.setTitle(action.title, for: .normal)
            self.setFromNeighbourhoodLocationPopUpButton(title: action.title)
            
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
            self.setToNeighbourhoodLocationPopUpButton(title: action.title)
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
    func setFromNeighbourhoodLocationPopUpButton(title:String){
        let number=kuTravelDataSource.getNumberOfNeighbourhood(with: title)
        let optionClosure = {(action: UIAction) in
            
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 0{
                children[i]=UIAction(title: kuTravelDataSource.getNeighbourhood(with: title , for: i) ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuTravelDataSource.getNeighbourhood(with: title , for: i) ?? "",handler: optionClosure)
            }
        }
        
        fromNeighbourhoodLocation.menu=UIMenu(children:children)
        fromNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        fromNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setToNeighbourhoodLocationPopUpButton(title:String){
        let number=kuTravelDataSource.getNumberOfNeighbourhood(with: title)
        let optionClosure = {(action: UIAction) in
            
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 0{
                children[i]=UIAction(title: kuTravelDataSource.getNeighbourhood(with: title , for: i) ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuTravelDataSource.getNeighbourhood(with: title , for: i) ?? "",handler: optionClosure)
            }
        }
        
        toNeighbourhoodLocation.menu=UIMenu(children:children)
        toNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        toNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    
    func setDefaultFromNeighbourhoodLocationPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
        self.fromNeighbourhoodLocation.menu=UIMenu(children: [
            UIAction(title: "From (Neighbourhood)", state: .on, handler: optionClosure),
        ])
        
        self.fromNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        self.fromNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
    }
    func setDefaultToNeighbourhoodLocationPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
        self.toNeighbourhoodLocation.menu=UIMenu(children: [
            UIAction(title: "To (Neighbourhood)", state: .on, handler: optionClosure),
        ])
        
        self.toNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        self.toNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
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
            if let fromNeighbourhood=fromNeighbourhoodLocation.currentTitle{
                ridesViewController.fromNeighbourhood = fromNeighbourhood
            }
            if let to = toLocation.currentTitle {
                ridesViewController.to = to
            }
            if let toNeighbourhood=toNeighbourhoodLocation.currentTitle {
                ridesViewController.toNeighbourhood = toNeighbourhood
            }
            let date = datePicker.date
            let time = timePicker.date
            let all = showAllSwitch.isOn
            
            ridesViewController.date = date
            ridesViewController.time = time
            ridesViewController.all = all
        }
    }
    
}







