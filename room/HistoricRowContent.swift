//
//  HistoricRowContent.swift
//  room
//
//  Created by Vamsi Ravula on 12/3/21.
//

import Foundation
import UIKit

class Atmosrow {
    var time: String
    var temp: String
    var humi: String
    
    init(time: String, temp: String, humi: String) {
        self.time = time
        self.temp = temp
        self.humi = humi
    }
}
