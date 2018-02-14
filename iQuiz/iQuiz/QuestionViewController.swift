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
    var chosenButtonNumber : Int? = nil
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.isEnabled = false
        
        var question1 = questions[0]
        
        questionLabel.text = question1.question
        question1.answerOptions.append(question1.correctAnswer)
        let allAnswers : [String] = question1.answerOptions
        var allOptionButtons : [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        
        //for the four available answers
        for index in 0...3 {
            //pick a random index number between 0 and the number of items in the allOptionButtons array
            //set that random option button to the next answerOption
            let randomIndex = Int(arc4random_uniform(UInt32(allOptionButtons.count)))
            allOptionButtons[randomIndex].setTitle(allAnswers[index], for: .normal)
            allOptionButtons.remove(at: randomIndex)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chosenOptionClicked(_ sender : UIButton) {
        self.chosenButtonNumber = sender.tag
        self.submitButton.isEnabled = trues
    }
    
    @IBAction func submitClicked(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainView = segue.destination as! ViewController
        mainView.questions = questions
    }
    

}
