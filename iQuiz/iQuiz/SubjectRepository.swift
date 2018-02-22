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
        self.subjects = []
        createSubjects(url: "https://tednewardsandbox.site44.com/questions.json")
    }
    
    func getSubjects() -> [Subject] {
        return subjects
    }
    
    func getSubject(id: Int) -> Subject {
        return subjects[id]
    }
    
    func setURL(url : String) -> Bool {
        return createSubjects(url: url)
    }
    
    private func createSubjects(url: String) -> Bool {
        var correctlyUpdated = false
        let url = NSURL(string: url)!
        let urlRequest = URLRequest(url: url as URL)
        self.subjects = []
        
        let sema = DispatchSemaphore(value: 0);
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if error != nil {
                NSLog("Problem connecting to internet. Getting data from local file.")
                self.getLocalData()
//                print(error ?? "URLSession error")
                sema.signal()
                return
            }
            correctlyUpdated = self.parseJSON(data: data!)
            sema.signal()
//            if self.parseJSON(data: data!) {
//                sema.signal()
//                correctlyUpdated = true
//            } else {
//                correctlyUpdated = false
//                sema.signal()
//            }
        }
        task.resume()
        sema.wait()
        if correctlyUpdated {
            NSLog("Updated subjects!")
        } else {
            self.createSubjects(url: "https://tednewardsandbox.site44.com/questions.json")
            NSLog("Problem with updating subjects. Updated subjects with default URL")
        }
        return correctlyUpdated
    }
    
    private func getLocalData() {
        do {
            let fileURLString = NSHomeDirectory() + "/Documents/json"
            let jsonData = NSArray(contentsOfFile: fileURLString)
            let data = try JSONSerialization.data(withJSONObject:jsonData!)
            self.parseJSON(data: data)
        } catch {
            print("JSON serialization failed: ", error)
        }
    }
    
    private func parseJSON(data : Data) -> Bool {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
            
                //write data
                let fileURLString = NSHomeDirectory() + "/Documents/json"
                let fileURL = URL(fileURLWithPath: fileURLString)
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
//                    let subjectImage = UIImage(named: subjectImageName)!
                    var subjectImage : UIImage
                    
                    if UIImage(named: subjectImageName) != nil {
                        subjectImage = UIImage(named: subjectImageName)!
                    } else {
                        subjectImage = #imageLiteral(resourceName: "defaultQIcon.jpg")
                    }
                    
                    
                    self.subjects.append(Subject(subjectTitle: item["title"] as! String, description: item["desc"] as! String, img: subjectImage, questionsArray: subjectQ))
                }
                return true
            } else {
                NSLog("invalid response")
                return false
            }
        } catch let jsonError {
            NSLog("Problem downloading!")
            print(jsonError)
            return false
        }
    }
    
//    private let subjects : [Subject] = [
//        Subject(subjectTitle: "Mathematics", description: "numbers and stuff", img: #imageLiteral(resourceName: "math"), questionsArray : [Question(question: "What's 1 + 1", correctAnswer: "2", answerOptions: ["3", "-1", "4"]),
//            Question(question: "What's the derivative of sin(x)?", correctAnswer: "cos(x)", answerOptions: ["tan(x)", "-cos(x)", "sec(x)"])]),
//        Subject(subjectTitle: "Marvel Super Heroes", description: "spiderman's world", img: #imageLiteral(resourceName: "marvel.jpg"), questionsArray : [Question(question: "What's spiderman's real name?", correctAnswer: "Peter Parker", answerOptions: ["Bruce Wayne", "Clark Kent", "Dick Grayson"])]),
//        Subject(subjectTitle: "Science", description: "chemistry, biology, etc", img: #imageLiteral(resourceName: "science.jpg"), questionsArray : [Question(question: "What's entropy?", correctAnswer: "Gradual decline into disorder", answerOptions: ["Heat", "Gradual change to liquid", "Gradual decline into order"])])
//    ]
//
}
