//
//  Week.swift
//  Schedule
//
//  Created by Adish Padhani on 12/13/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import Foundation

class Week {
    var week:String?
    var items:NSArray = [Item]() as NSArray
    var weekNumber: Int?
    
    init(week:String, weekNumber:Int) {
        self.week = week
        self.weekNumber = weekNumber
    }
}
