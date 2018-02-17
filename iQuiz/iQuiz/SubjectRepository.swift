//
//  SubjectRepository.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/12/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    var question: String
    var correctAnswer : String
    var answerOptions : [String]
}

class Subject {
    var title : String
    var description : String
    var image : UIImage
    var questions: [Question]
    
    init(subjectTitle : String, description : String, img : UIImage, questionsArray : [Question]) {
        self.title = subjectTitle
        self.description = description
        self.image = img
        self.questions = questionsArray
    }
}

class SubjectRepository {
    static let shared = SubjectRepository()
    
    private var subjects : [Subject]
    
    init() {
        let urlString : String = "https://tednewardsandbox.site44.com/questions.json"
        let url = NSURL(string: urlString)!
        let urlRequest = URLRequest(url: url as URL)
        self.subjects = []
        
        let sema = DispatchSemaphore(value: 0);
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "URLSession error")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: AnyObject]]
                
                let fileURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/json")
                try (json as NSArray).write(to: fileURL)
              
                
                //for each subject in json file..
                for item in json {
                    var subjectQ : [Question] = []
                    
                    let questionsArray = item["questions"] as? [AnyObject]
                    for question in questionsArray! {
                        let questionText = question["text"]
                        let questionAnswerIndex = (question["answer"] as! NSString).integerValue
                        var questionAnswers = question["answers"] as? [AnyObject]
                        let correctAnswer = questionAnswers!.remove(at: questionAnswerIndex-1)
                        subjectQ.append(Question(question: questionText as! String, correctAnswer: correctAnswer as! String, answerOptions: questionAnswers! as! [String]))
                    }
                    
                    let subjectImageName : String = ((item["title"] as! NSString) as String) + ".jpg"
                    let subjectImage = UIImage(named: subjectImageName)!
                    
                    
                    self.subjects.append(Subject(subjectTitle: item["title"] as! String, description: item["desc"] as! String, img: subjectImage, questionsArray: subjectQ))
                }
            } catch let jsonError {
                print(jsonError)
            }
            sema.signal();
        }
        task.resume()
        sema.wait()
    }
    
    func getSubjects() -> [Subject] {
        return subjects
    }
    
    func getSubject(id: Int) -> Subject {
        return subjects[id]
    }
    
    
//    private let subjects : [Subject] = [
//        Subject(subjectTitle: "Mathematics", description: "numbers and stuff", img: #imageLiteral(resourceName: "math"), questionsArray : [Question(question: "What's 1 + 1", correctAnswer: "2", answerOptions: ["3", "-1", "4"]),
//            Question(question: "What's the derivative of sin(x)?", correctAnswer: "cos(x)", answerOptions: ["tan(x)", "-cos(x)", "sec(x)"])]),
//        Subject(subjectTitle: "Marvel Super Heroes", description: "spiderman's world", img: #imageLiteral(resourceName: "marvel.jpg"), questionsArray : [Question(question: "What's spiderman's real name?", correctAnswer: "Peter Parker", answerOptions: ["Bruce Wayne", "Clark Kent", "Dick Grayson"])]),
//        Subject(subjectTitle: "Science", description: "chemistry, biology, etc", img: #imageLiteral(resourceName: "science.jpg"), questionsArray : [Question(question: "What's entropy?", correctAnswer: "Gradual decline into disorder", answerOptions: ["Heat", "Gradual change to liquid", "Gradual decline into order"])])
//    ]
//
}
