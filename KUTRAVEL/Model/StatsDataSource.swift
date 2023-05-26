//
//  StatsDataSource.swift
//  KUTRAVEL
//
//  Created by Begum Sen on 26.05.2023.
//

import Foundation

class StatsDataSource {
    
    
    var delegate: StatsDataDelegate?
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    
    init() {
    }
    
    func getStats(){
        self.delegate?.statsAreLoaded()
    }
}
