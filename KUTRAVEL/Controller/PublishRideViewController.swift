
import UIKit
import Foundation

class PublishRideViewController: UIViewController {
    
    
    @IBOutlet weak var fromLocation: UIButton!
    
    @IBOutlet weak var errorText: UILabel!
    
    @IBOutlet weak var toLocation: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var feeSlider: UISlider!
    
    @IBOutlet weak var feeField: UILabel!
    
    @IBOutlet weak var numberOfSeatsField: UISegmentedControl!
    private let kuberDataSource=KuberDataSource()
    
    let publishRideHelper = PublishRideHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishRideHelper.delegate = self
        // Do any additional setup after loading the view.
        setFromLocationPopUpButton()
        setToLocationPopUpButton()
        //feeField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromLocation.setTitle("From (District)", for: .normal)
        toLocation.setTitle("To (District)", for: .normal)
       
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func publishButtonClicked(_ sender: UIButton) {
        
        let date = datePicker.date
        let feeNum=Int(feeSlider.value)
        let fee = "\(feeNum)"
        let numberOfSeats=numberOfSeatsField.selectedSegmentIndex+1
        if let from = fromLocation.currentTitle,
           let to = toLocation.currentTitle {
            if from == "From (District)" || to == "To (District)"  {
                errorText.text = "Please enter all necessary information"
                errorText.isHidden = false
                errorText.textColor = UIColor.red
                errorText.adjustsFontSizeToFitWidth = true
            }else{
                publishRideHelper.saveRide(from: from,  to: to, date: date, fee: fee, numberOfSeats: numberOfSeats)
            }
        }
        
        
    }
    
    @IBAction func feeSliderChanged(_ sender: UISlider) {
        let fee=Int(feeSlider.value)
        feeField.text="\(fee) TL"
    }
    
    func setFromLocationPopUpButton(){
        let arraySize=kuberDataSource.getNumberDistricts()
        let iteration=arraySize-1
        let optionClosure = {(action: UIAction) in
            self.fromLocation.setTitle(action.title, for: .normal)
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: arraySize)
        for i in 0...iteration{
            if i == 1{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        fromLocation.menu=UIMenu(children:children)
        fromLocation.showsMenuAsPrimaryAction=true
        fromLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setToLocationPopUpButton(){
        let arraySize=kuberDataSource.getNumberDistricts()
        let iteration=arraySize-1
        let optionClosure = {(action: UIAction) in
            self.toLocation.setTitle(action.title, for: .normal)
            
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: arraySize)
        for i in 0...iteration{
            if i == 1{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        toLocation.menu=UIMenu(children:children)
        toLocation.showsMenuAsPrimaryAction=true
        toLocation.changesSelectionAsPrimaryAction=true
        
        
    }
   
    
}
extension PublishRideViewController: PublishRideDelegate {
    func publishedToDatabase(){
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
}

extension PublishRideViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
