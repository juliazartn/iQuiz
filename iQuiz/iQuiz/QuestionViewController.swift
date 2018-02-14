//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/13/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions : [Question] = []
    var questionIndex : Int = 0
    var chosenButtonNumber : Int? = nil
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var allOptionButtons : [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allOptionButtons = [option1Button, option2Button, option3Button, option4Button]
        self.submitButton.isEnabled = false
        
        var currentQuestion = questions[questionIndex]
        
        questionLabel.text = currentQuestion.question
        currentQuestion.answerOptions.append(currentQuestion.correctAnswer)
        let allAnswers : [String] = currentQuestion.answerOptions
        var tempAllOptionButtons : [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        
        //for the four available answers
        for index in 0...3 {
            //pick a random index number between 0 and the number of items in the allOptionButtons array
            //set that random option button to the next answerOption
            let randomIndex = Int(arc4random_uniform(UInt32(tempAllOptionButtons.count)))
            tempAllOptionButtons[randomIndex].setTitle(allAnswers[index], for: .normal)
            tempAllOptionButtons.remove(at: randomIndex)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chosenOptionClicked(_ sender : UIButton) {
        self.chosenButtonNumber = sender.tag
        
        for index in 0...3 {
            allOptionButtons[index].setTitleColor(UIColor.black, for: .normal)
        }

 allOptionButtons[sender.tag].setTitleColor(UIColor.orange , for: .normal)
        
        self.submitButton.isEnabled = true
    }
    
    @IBAction func submitClicked(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let answerView = segue.destination as! AnswerViewController
        answerView.questions = questions
        answerView.questionIndex = questionIndex
        answerView.selectedAnswerText = (allOptionButtons[chosenButtonNumber!].titleLabel?.text)!
    }
}
