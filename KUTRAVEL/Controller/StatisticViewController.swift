

import UIKit

class StatisticViewController: UIViewController {

    
    @IBOutlet weak var firstStat: UILabel!
    
    @IBOutlet weak var secondStat: UILabel!
    
    @IBOutlet weak var thirdStat: UILabel!
    
    @IBOutlet weak var fourthStat: UILabel!
    
    
    let statsDataSource = StatsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsDataSource.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        statsDataSource.getStats()
        print("getStats()")
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

extension StatisticViewController: StatsDataDelegate {
    
    func statsAreLoaded() {
        firstStat.text = statsDataSource.first
        secondStat.text = statsDataSource.second
        thirdStat.text = statsDataSource.third
        fourthStat.text = statsDataSource.fourth
    }
    
}
