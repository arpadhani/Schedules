//
//  WeekScheduleViewController.swift
//  Schedule
//
//  Created by Adish Padhani on 12/6/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit

class WeekScheduleViewController: UIViewController {

    @IBOutlet weak var itemsTableView: UITableView!

    var items = [Item]() {
        didSet {
            if itemsTableView != nil {
                items.sort {
                    $0.ID < $1.ID
                }
                itemsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.rowHeight = UITableViewAutomaticDimension
        itemsTableView.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Get It Done"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension WeekScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //there will need to be some tailoring done here to allow users to select items/tasks. 
        if let itemDone = UserDefaults.standard.value(forKey: "\(items[indexPath.row].ID)") {
            UserDefaults.standard.setValue(!(itemDone as! Bool), forKey: "\(items[indexPath.row].ID)")
        }else {
            UserDefaults.standard.setValue(true, forKey: "\(items[indexPath.row].ID)")
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
}


extension WeekScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITEMCELL") as! ItemCellTableViewCell
        cell.prepareForReuse()
        cell.item = items[indexPath.row]
        if let itemDone = UserDefaults.standard.value(forKey: "\(items[indexPath.row].ID)") {
            if itemDone as! Bool == true {
                cell.accessoryType = .checkmark
            }else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
