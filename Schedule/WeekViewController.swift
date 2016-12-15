//
//  WeekViewController.swift
//  Schedule
//
//  Created by Adish Padhani on 12/6/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WeekViewController: UIViewController {

    @IBOutlet weak var weekTableView: UITableView!
    var weeks = [Week]()
    let ref = FIRDatabase.database().reference()
    
    var gmatScheduleType: String? {
        didSet {
            if gmatScheduleType == "6 Month GMAT" {
                download6monthGmat()
                self.title = "GMAT Schedules"
            }
            self.title = gmatScheduleType!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weekTableView.delegate = self
        weekTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weekTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func download6monthGmat() {
        
        ref.child("6MonthGMAT") .observeSingleEvent(of: .value) { (snapshot:FIRDataSnapshot) in
            
            for weekIterator in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let tasksDictionary = weekIterator.value as! NSDictionary
                let week = Week.init(week: weekIterator.key, weekNumber: tasksDictionary.value(forKey: "WeekNumber") as! Int)
                let tasks =  tasksDictionary.value(forKey: "Tasks") as! [NSDictionary]
                
                var items = [Item]()
                
                for task in tasks {
                    let item = Item.init(day: task.value(forKey: "Day") as! String,
                                         description: task.value(forKey: "Description") as! String,
                                         ID: task.value(forKey: "ID") as! Int,
                                         task: task.value(forKey: "Task") as! String,
                                         week: task.value(forKey: "Week") as! String)
                    items.append(item)
                    week.items = items as NSArray
                }
                self.weeks.append(week)
            }
            DispatchQueue.main.async {
                self.weeks.sort {
                    $0.weekNumber! < $1.weekNumber!
                }
                self.weekTableView.reloadData()
            }
        }
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToWeekSchedule" {
            let wsvc = segue.destination as! WeekScheduleViewController
            if sender != nil {
                wsvc.items = sender as! [Item]
            }
        }
    }
}

extension WeekViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = weeks[indexPath.row].items
        self.title = weeks[indexPath.row].week
        self.performSegue(withIdentifier: "SegueToWeekSchedule", sender: items)
        
    }
}


extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WEEKCELL")
        cell?.textLabel?.text = weeks[indexPath.row].week
        cell?.accessoryType = accessoryForCompletedWeek(week: weeks[indexPath.row]) ? .checkmark : .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
    
    private func accessoryForCompletedWeek (week: Week) -> Bool {
        for item in week.items {
            if let itemDone = UserDefaults.standard.value(forKey: "\((item as! Item).ID)") {
                if itemDone as! Bool == false {
                    return false
                }
            }else {
                return false
            }
        }
        return true
    }
}
