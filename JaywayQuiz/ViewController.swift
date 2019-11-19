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
    var currentGameQuestions = question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: 10)
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel0: UIButton!
    @IBOutlet weak var answerLabel1: UIButton!
    @IBOutlet weak var answerLabel2: UIButton!
    @IBOutlet weak var answerLabel3: UIButton!
        
    
    func presentQuestion(questionObjects: [question]) {
        
        let question = questionObjects[0]
        
        answerLabel0.setTitle(question.answers[0], for: .normal)
        answerLabel1.setTitle(question.answers[1], for: .normal)
        answerLabel2.setTitle(question.answers[2], for: .normal)
        answerLabel3.setTitle(question.answers[3], for: .normal)
        questionLabel.text = question.questionString
        currentCorrectAnswer = question.correctAnswer
        
        answerLabel0.tintColor = .systemBlue
        answerLabel1.tintColor = .systemBlue
        answerLabel2.tintColor = .systemBlue
        answerLabel3.tintColor = .systemBlue
    }
    
    func checkAnswer(answer: String) -> Bool {
        currentGameQuestions.remove(at: 0)
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
        presentQuestion(questionObjects: currentGameQuestions)
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
        presentQuestion(questionObjects: currentGameQuestions)
    }
}

