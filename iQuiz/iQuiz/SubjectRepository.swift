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
    
    func getSubjects() -> [Subject] {
        return subjects
    }
    
    func getSubject(id: Int) -> Subject {
        return subjects[id]
    }
    
    private let subjects : [Subject] = [
        Subject(subjectTitle: "Mathematics", description: "numbers and stuff", img: #imageLiteral(resourceName: "math"), questionsArray : [Question(question: "What's 1 + 1", correctAnswer: "2", answerOptions: ["3", "-1", "4"])]),
        Subject(subjectTitle: "Marvel Super Heroes", description: "spiderman's world", img: #imageLiteral(resourceName: "marvel.jpg"), questionsArray : [Question(question: "What's spiderman's real name?", correctAnswer: "Peter Parker", answerOptions: ["Bruce Wayne", "Clark Kent", "Dick Grayson"])]),
        Subject(subjectTitle: "Science", description: "chemistry, biology, etc", img: #imageLiteral(resourceName: "science.jpg"), questionsArray : [Question(question: "What's entropy?", correctAnswer: "Gradual decline into disorder", answerOptions: ["Heat", "Gradual change to liquid", "Gradual decline into order"])])
    ]
}
