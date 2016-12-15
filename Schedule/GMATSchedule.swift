//
//  GMATSchedule.swift
//  Schedule
//
//  Created by Adish Padhani on 12/6/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit

class GMATSchedule: UIViewController {
    
    @IBOutlet weak var gmatTableView: UITableView!
    let gmatScheduleArray = ["6 Month GMAT", "3 Month GMAT (Placeholder)", "1 Month GMAT (Placeholder)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gmatTableView.delegate = self
        gmatTableView.dataSource = self
        gmatTableView.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "GMAT Schedules"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToWeek" {
            let wvc = segue.destination as! WeekViewController
            if let gmatScheduleType = sender {
                wvc.gmatScheduleType = gmatScheduleType as? String
            }
        }
    }
}


extension GMATSchedule: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let schedule =  tableView.cellForRow(at: indexPath)?.textLabel?.text {
            self.performSegue(withIdentifier: "SegueToWeek", sender: schedule)
        }
    }
}


extension GMATSchedule: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GMATSCHEDULECELL")
        cell?.textLabel?.text = gmatScheduleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gmatScheduleArray.count
    }
}










