//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/16/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var URLTextField: UITextField!
    
    var subjectRepo : SubjectRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        URLTextField.text = "https://tednewardsandbox.site44.com/questions.json"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkNowClicked(_ sender: Any) {
        //update subjects with new information
        subjectRepo?.setURL(url: URLTextField.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mainView = segue.destination as! ViewController
        mainView.subjectRepo = subjectRepo!
    }

}
