//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/14/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    var totalQuestions = 0
    var score = 0
    
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score) / \(totalQuestions)"
        
        let scorePercent = Double(score)/Double(totalQuestions)
//        NSLog("scorePercent is \(scorePercent)")
        
        if scorePercent == 1 {
            performanceLabel.text = "Perfect!"
        } else if scorePercent > 0.8 {
            performanceLabel.text = "Almost!"
        } else if scorePercent > 0.7 {
            performanceLabel.text = "C's get degrees!"
        } else {
            performanceLabel.text = "Keep practicing!"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
