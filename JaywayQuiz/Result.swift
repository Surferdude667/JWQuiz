//
//  Result.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 21/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation

var resultPack: Result?

//  USED FOR RESULT
var resultTime = [Int]()
var resultCorrectAnswer: Int!
var resultWrongAnswer: Int!
var resutlUnanswered: Int!
var resultLifelinesUsed: Int!

struct Result {
    var correctAnswers: Int
    var wrongAnswers: Int
    var unansweredAnswers: Int
    var answerTime = [Int]()
    var lifelinesUsed: Int
    
    static func captureResult() {
        resultPack = Result(correctAnswers: resultCorrectAnswer,
                                 wrongAnswers: resultWrongAnswer,
                                 unansweredAnswers: resutlUnanswered,
                                 answerTime: resultTime,
                                 lifelinesUsed: resultLifelinesUsed)
        print(resultPack!)
    }
}

