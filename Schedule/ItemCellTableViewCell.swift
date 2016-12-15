//
//  ItemCellTableViewCell.swift
//  Schedule
//
//  Created by Adish Padhani on 12/14/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var taskIconLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    
    var item:Item? {
        didSet {
            if let firstLetter = item?.task?.characters.first {
                taskIconLabel.text = "\(firstLetter)"
            }
            if let task = item?.task {
                if let day = item?.day {
                  taskNameLabel.text =  "\(task): \(day)"
                }
            }
            taskDescriptionTextView.text = item?.description
            
            
        }
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
        self.taskIconLabel.text = ""
        self.taskNameLabel.text = ""
        self.taskDescriptionTextView.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
