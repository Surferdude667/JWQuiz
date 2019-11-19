//
//  data.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 19/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit

class question {
    let questionID: Int
    let questionString: String
    let questionImage: UIImage?
    let answers: [String]
    let correctAnswer: String
    
    init(questionID: Int, questionString: String, questionImage: UIImage?, answers: [String], correctAnswer: String) {
        self.questionID = questionID
        self.questionString = questionString
        self.questionImage = questionImage
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
}

let questionArray = [question(questionID: 1, questionString: "Question?", questionImage: nil, answers: ["Answer1", "Answer2", "Answer3", "Answer4"], correctAnswer: "Answer3"), question(questionID: 2, questionString: "QUESTION?", questionImage: nil, answers: ["ANSWER1", "ANSWER2", "ANSWER3", "ANSWER4"], correctAnswer: "ANSWER1")]
