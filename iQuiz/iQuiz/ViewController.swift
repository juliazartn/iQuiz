//
//  ViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/8/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tblSubjects: UITableView!
    
    let subjectRepo = SubjectRepository.shared
    var subjects : [Subject]? = nil
    var questions : [Question] = []
    
    //return number of subjects
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects!.count
    }
    
    //return cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let subject = subjects![index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectTableViewCell
        cell.subjectTitle?.text = subject.title
        cell.subjectDescription?.text = subject.description
        cell.subjectImageView?.image = subject.image
        return cell
    }
    
    @IBAction func settingsPushed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings Alert", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subjects = UIApplication.shared.subjectRepository.getSubjects()

        tblSubjects.dataSource = self
        tblSubjects.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = subjects![indexPath.row]
        questions = subject.questions
        
        NSLog("User selected row at \(subject.title) and the questions are: \(String(describing: questions))")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionView = segue.destination as! QuestionViewController
        NSLog("preparing the questions: \(questions)")
        tblSubjects.indexPathForSelectedRow?.row
        questionView.questions = questions
    }


}

