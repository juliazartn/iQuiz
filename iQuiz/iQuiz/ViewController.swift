//
//  ViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/8/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    
    class Subject {
        var title : String
        var description : String
        
        init(subjectTitle : String, description : String) {
            self.title = subjectTitle
            self.description = description
        }
    }
    
    @IBOutlet weak var tblSubjects: UITableView!
    let subjects : [Subject] = [
        Subject(subjectTitle: "Mathematics", description: "numbers and stuff"),
        Subject(subjectTitle: "Marvel Super Heroes", description: "spiderman's world"),
        Subject(subjectTitle: "Science", description: "chemistry, biology, etc")
    ]
    
    
    //return number of subjects
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    //return cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let subject = subjects[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectTableViewCell
        cell.subjectTitle?.text = subject.title
        cell.subjectDescription?.text = subject.description
        return cell
    }
    
    @IBOutlet weak var SettingsBtn: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblSubjects.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

