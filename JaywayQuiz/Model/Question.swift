//
//  data.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 19/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit


class Question {
    let questionID: Int
    let questionString: String
    let questionImage: String
    let answers: [String]
    let correctAnswer: String
    var isQuestionUsed: used
    
    enum used {
        case used
        case notUsed
    }
    
    init(questionID: Int, questionString: String, questionImage: String, answers: [String], correctAnswer: String) {
        self.questionID = questionID
        self.questionString = questionString
        self.questionImage = questionImage
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.isQuestionUsed = .notUsed
    }
    
        
    //  PREPARS THE QUESTIONS NEEDED FOR ONE GAME
    //  CHECKS WHICH QUESTIONS ARE USED AND USES THOSE FIRST
    //  RETURNS A READY ARRAY OF QUESTIONS
    static func prepareQuestionsForGame(questionObjects: [Question]) -> [Question] {
        
        let shuffledData = questionObjects.shuffled()
        
        let unusedQuestions = shuffledData.filter(){$0.isQuestionUsed == .notUsed}
        let usedQuestions = shuffledData.filter(){$0.isQuestionUsed == .used}
                
        var gameReadyQuestions = [Question]()
    
        if unusedQuestions.count >= config.numberOfQuestionsInGame {
            //  All good, adding only unused questions.
            gameReadyQuestions = Array(unusedQuestions.prefix(config.numberOfQuestionsInGame))
        } else {
            let neededQuestions = config.numberOfQuestionsInGame - unusedQuestions.count
            
            //  Adding unused questions.
            for i in 0..<config.numberOfQuestionsInGame - neededQuestions {
                gameReadyQuestions.append(unusedQuestions[i])
            }
            
            //  Adding used questions.
            for i in 0..<neededQuestions {
                gameReadyQuestions.append(usedQuestions[i])
            }
        }
       return gameReadyQuestions
    }
    
    static func markQuestionsAsUsed(questionToRemove: Question) {
        //  MARKS THE QUESTION THAT HAVE BEEN PRESENTED IN THIS ROUND AS .USED IN ORIGINAL DATA.
        if let index = questionArray.firstIndex(where: { $0.questionID == questionToRemove.questionID }) {
            questionArray[index].isQuestionUsed = .used
            print(questionArray[index].questionID)
        }
    }
    
}
