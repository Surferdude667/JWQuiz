//
//  data.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 19/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit



var questionArray = [question(questionID: 1, questionString: "A - Question?", questionImage: nil, answers: ["A - Answer1", "A - Answer2", "A - Answer3", "A - Answer4"], correctAnswer: "A - Answer3"), question(questionID: 2, questionString: "B - QUESTION?", questionImage: nil, answers: ["B - ANSWER1", "B - ANSWER2", "B - ANSWER3", "B - ANSWER4"], correctAnswer: "B - ANSWER1"), question(questionID: 3, questionString: "C - QUESTION?", questionImage: nil, answers: ["C - ANSWER1", "C - ANSWER2", "C - ANSWER3", "C - ANSWER4"], correctAnswer: "C - ANSWER1"), question(questionID: 4, questionString: "D - QUESTION?", questionImage: nil, answers: ["D - ANSWER1", "D - ANSWER2", "D - ANSWER3", "D - ANSWER4"], correctAnswer: "D - ANSWER1"), question(questionID: 5, questionString: "E - QUESTION?", questionImage: nil, answers: ["E - ANSWER1", "E - ANSWER2", "E - ANSWER3", "E - ANSWER4"], correctAnswer: "E - ANSWER1"), question(questionID: 6, questionString: "F - QUESTION?", questionImage: nil, answers: ["F - ANSWER1", "F - ANSWER2", "F - ANSWER3", "F - ANSWER4"], correctAnswer: "F - ANSWER1"), question(questionID: 7, questionString: "G - QUESTION?", questionImage: nil, answers: ["G - ANSWER1", "G - ANSWER2", "G - ANSWER3", "G - ANSWER4"], correctAnswer: "G - ANSWER1"), question(questionID: 8, questionString: "H - QUESTION?", questionImage: nil, answers: ["H - ANSWER1", "H - ANSWER2", "H - ANSWER3", "H - ANSWER4"], correctAnswer: "H - ANSWER1"), question(questionID: 9, questionString: "I - QUESTION?", questionImage: nil, answers: ["I - ANSWER1", "I - ANSWER2", "I - ANSWER3", "I - ANSWER4"], correctAnswer: "I - ANSWER1"), question(questionID: 10, questionString: "J - QUESTION?", questionImage: nil, answers: ["J - ANSWER1", "J - ANSWER2", "J - ANSWER3", "J - ANSWER4"], correctAnswer: "J - ANSWER1"), question(questionID: 11, questionString: "K - QUESTION?", questionImage: nil, answers: ["K - ANSWER1", "K - ANSWER2", "K - ANSWER3", "K - ANSWER4"], correctAnswer: "K - ANSWER1"), question(questionID: 12, questionString: "L - QUESTION?", questionImage: nil, answers: ["L - ANSWER1", "L - ANSWER2", "L - ANSWER3", "L - ANSWER4"], correctAnswer: "L - ANSWER1")]



struct question {
    let questionID: Int
    let questionString: String
    let questionImage: UIImage?
    let answers: [String]
    let correctAnswer: String
    var isQuestionUsed: used
    
    enum used {
        case used
        case notUsed
    }
    
    init(questionID: Int, questionString: String, questionImage: UIImage?, answers: [String], correctAnswer: String) {
        self.questionID = questionID
        self.questionString = questionString
        self.questionImage = questionImage
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.isQuestionUsed = .notUsed
    }
}
