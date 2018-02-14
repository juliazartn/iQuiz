//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/14/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var questions : [Question] = []
    var questionIndex : Int = 0
    var selectedAnswerText : String? = nil
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var correctAnswerTextLabel: UILabel!
    @IBOutlet weak var outcomeTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextLabel.text = questions[questionIndex].question
        correctAnswerTextLabel.text = questions[questionIndex].correctAnswer
        
        if questions[questionIndex].correctAnswer == selectedAnswerText {
            outcomeTextLabel.textColor = UIColor.green
            outcomeTextLabel.text = "Correct!"
        } else {
            outcomeTextLabel.textColor = UIColor.red
            outcomeTextLabel.text = "Wrong :("
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
