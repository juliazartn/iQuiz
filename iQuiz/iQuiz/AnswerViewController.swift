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
    var score : Int = 0
    
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
            score = score + 1
        } else {
            outcomeTextLabel.textColor = UIColor.red
            outcomeTextLabel.text = "Wrong :("
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        if questionIndex == questions.count - 1 {
            self.performSegue(withIdentifier: "finishedSegue", sender: nil)
        } else {
            self.performSegue(withIdentifier: "anotherQuestionSegue", sender: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "anotherQuestionSegue" {
            let questionView = segue.destination as! QuestionViewController
            questionView.questions = questions
            questionView.questionIndex = questionIndex + 1
            questionView.score = score
        }
        else {
            let finishedView = segue.destination as! FinishedViewController
            finishedView.totalQuestions = questions.count
            finishedView.score = score
        }
    }
}
