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
    var currentGameQuestions = Question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: 3)
    var timer = Timer()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel0: UIButton!
    @IBOutlet weak var answerLabel1: UIButton!
    @IBOutlet weak var answerLabel2: UIButton!
    @IBOutlet weak var answerLabel3: UIButton!
    
    
    //  Presents a new question and marks the question as .used in original data.
    func presentQuestion(questionObjects: [Question]) {
        
        let currentQuestion = questionObjects[0]
        
        answerLabel0.setTitle(currentQuestion.answers[0], for: .normal)
        answerLabel1.setTitle(currentQuestion.answers[1], for: .normal)
        answerLabel2.setTitle(currentQuestion.answers[2], for: .normal)
        answerLabel3.setTitle(currentQuestion.answers[3], for: .normal)
        questionLabel.text = currentQuestion.questionString
        currentCorrectAnswer = currentQuestion.correctAnswer
        
        //  MARKS THE QUESTION THAT HAVE BEEN PRESENTED IN THIS ROUND AS .USED IN ORIGINAL DATA
        if let index = questionArray.firstIndex(where: { $0.questionID == questionArray[0].questionID }) {
            questionArray[index].isQuestionUsed = .used
        }
    }
    
    func resetQuestion() {
        answerLabel0.tintColor = .systemBlue
        answerLabel1.tintColor = .systemBlue
        answerLabel2.tintColor = .systemBlue
        answerLabel3.tintColor = .systemBlue
        
        //  Remove the answer from the list
        if currentGameQuestions.count >= 1 {
            currentGameQuestions.remove(at: 0)
        }
    }
    
    func disableButtons(_ trueOrFalse: Bool) {
        answerLabel0.isUserInteractionEnabled = trueOrFalse
        answerLabel1.isUserInteractionEnabled = trueOrFalse
        answerLabel2.isUserInteractionEnabled = trueOrFalse
        answerLabel3.isUserInteractionEnabled = trueOrFalse
    }
    
    
    func presentNextQuestion() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.resetQuestion()
            
            if self.currentGameQuestions.count != 0 {
                self.presentQuestion(questionObjects: self.currentGameQuestions)
                self.disableButtons(true)
            } else if self.currentGameQuestions.count == 0 {
                print("Game over")
                self.questionLabel.text = "Game is over!"
                self.disableButtons(false)
            }
        }
    }
    
    func checkAnswer(answer: String) -> Bool {
        presentNextQuestion()
        disableButtons(false)
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
            if checkAnswer(answer: buttonTitle) {
                sender.tintColor = UIColor.green
            } else {
                sender.tintColor = UIColor.red
            }
        }
    }
}

