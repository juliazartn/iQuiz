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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
