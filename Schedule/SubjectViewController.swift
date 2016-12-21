//
//  SubjectViewController.swift
//  Schedule
//
//  Created by Adish Padhani on 12/20/16.
//  Copyright © 2016 A. R. Padhani. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {

    @IBOutlet weak var subjectTableView: UITableView!
    let subjectsArray = ["GMAT", "GRE", "LSAT", "MCAT"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        subjectTableView.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "GMAT Subjects"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = "Subjects"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ssvc = segue.destination as! SubjectScheduleViewController
        ssvc.subject = sender as? String
    }
    

}

extension SubjectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject =  subjectsArray[indexPath.row]
        self.performSegue(withIdentifier: "SegueToSubjectSchedule", sender: subject)
    }
    
}


extension SubjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SUBJECTCELL")
        cell?.textLabel?.text = subjectsArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsArray.count
    }
}
