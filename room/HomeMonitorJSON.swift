//
//  HomeMonitorJSON.swift
//  room
//
//  Created by Vamsi Ravula on 26/2/21.
//

import Foundation

struct HomeMonitorJSON: Codable {
    
    var humidity: Int = 0
    var temperature:Int = 0
    var date:String = ""
    var ctime:String = ""
}
