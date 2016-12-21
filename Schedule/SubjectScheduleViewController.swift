//
//  SubjectScheduleViewController.swift
//  Schedule
//
//  Created by Adish Padhani on 12/20/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit

class SubjectScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleTableView: UITableView!
    var scheduleArray = [String]()
    var subject: String? {
        didSet {
            if let subject = subject {
                self.title = subject
                
                switch subject {
                case "GMAT":
                    scheduleArray = ["6 Month GMAT", "3 Month GMAT (Placeholder)", "1 Month GMAT (Placeholder)"]
                case "GRE":
                    scheduleArray = []
                //complete here
                default: break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.tableFooterView = UIView.init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToWeeks" {
            let wvc = segue.destination as! WeekViewController
            wvc.scheduleType = sender as? String
        }
    }
}


extension SubjectScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule =  scheduleArray[indexPath.row]
        self.performSegue(withIdentifier: "SegueToWeeks", sender: schedule)
    }
}


extension SubjectScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GMATSCHEDULECELL")
        cell?.textLabel?.text = scheduleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
}

