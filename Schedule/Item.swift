//
//  Item.swift
//  
//
//  Created by Adish Padhani on 12/6/16.
//
//

import Foundation

class Item {
    var day:String?
    var description:String?
    var ID: Int
    var task: String?
    var week: String?
    
    init(day:String, description:String, ID:Int, task:String, week:String) {
        self.day = day
        self.description = description
        self.ID = ID
        self.task = task
        self.week = week
    }
    

}
