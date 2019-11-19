//
//  ViewController.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 19/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentCorrectAnswer: String?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel0: UIButton!
    @IBOutlet weak var answerLabel1: UIButton!
    @IBOutlet weak var answerLabel2: UIButton!
    @IBOutlet weak var answerLabel3: UIButton!
    
    
    func prepareQuestionsForGame(questionObjects: [question], numberOfQuestions: Int) {
        
        let shuffledData = questionObjects.shuffled()
        
        let unusedQuestions = shuffledData.filter(){$0.isQuestionUsed == .notUsed}
        let usedQuestions = shuffledData.filter(){$0.isQuestionUsed == .used}
        
        print("UNUSED QUESTIONS: \(unusedQuestions.count)")
        print("USED QUESTIONS: \(usedQuestions.count)")
        
        var gameReadyQuestions = [question]()
    
        if unusedQuestions.count >= numberOfQuestions {
            gameReadyQuestions = Array(unusedQuestions.prefix(numberOfQuestions))
        } else {
            
            let neededQuestions = 10 - unusedQuestions.count
            
            for i in 0..<10 - neededQuestions {
                gameReadyQuestions.append(unusedQuestions[i])
                print("Appending: \(unusedQuestions[i].questionString)")
            }
            
            print("NEEDED: \(neededQuestions)")
            for i in 0..<neededQuestions {
                gameReadyQuestions.append(usedQuestions[i])
                print("Appending: \(usedQuestions[i].questionString)")
            }
            
        }
        
        //  MARK THE QUESTIONS THAT HAVE BEEN USED
        for elements in gameReadyQuestions {
            if let index = questionArray.firstIndex(where: { $0.questionID == elements.questionID }) {
                questionArray[index].isQuestionUsed = .used
            }
        }
        
    }
    
    
    
    
    func presentQuestion(questionObjects: [question]) {
        let randomQuestion = questionObjects.randomElement()
        
        answerLabel0.setTitle(randomQuestion?.answers[0], for: .normal)
        answerLabel1.setTitle(randomQuestion?.answers[1], for: .normal)
        answerLabel2.setTitle(randomQuestion?.answers[2], for: .normal)
        answerLabel3.setTitle(randomQuestion?.answers[3], for: .normal)
        questionLabel.text = randomQuestion?.questionString
        currentCorrectAnswer = randomQuestion?.correctAnswer
    }
    
    func checkAnswer(answer: String) -> Bool {
        if answer == currentCorrectAnswer {
            print("Correct answer!")
            return true
        } else {
            print("Wrong answer!")
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentQuestion(questionObjects: questionArray)
        prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestions: 10)
    }
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if checkAnswer(answer: buttonTitle) == true {
                sender.tintColor = UIColor.green
            } else {
                sender.tintColor = UIColor.red
            }
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestions: 10)
    }
}

