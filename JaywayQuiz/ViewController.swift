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
    var currentGameQuestions = Question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: 10)
    var timer = Timer()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel0: UIButton!
    @IBOutlet weak var answerLabel1: UIButton!
    @IBOutlet weak var answerLabel2: UIButton!
    @IBOutlet weak var answerLabel3: UIButton!
        
    
    func presentQuestion(questionObjects: [Question]) {
        
        let Question = questionObjects[0]
        
        print("Present is called! \(Question.questionID)")
        
        answerLabel0.setTitle(Question.answers[0], for: .normal)
        answerLabel1.setTitle(Question.answers[1], for: .normal)
        answerLabel2.setTitle(Question.answers[2], for: .normal)
        answerLabel3.setTitle(Question.answers[3], for: .normal)
        questionLabel.text = Question.questionString
        currentCorrectAnswer = Question.correctAnswer
        
        //  MARK THE QUESTIONS THAT HAVE BEEN USED IN THIS GAME
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
        if currentGameQuestions.count != 1 {
            print("Removes element!")
            currentGameQuestions.remove(at: 0)
        } else {
            questionLabel.text = "Game is over!"
        }
    }
    
    func checkAnswer(answer: String) -> Bool {
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.resetQuestion()
            self.presentQuestion(questionObjects: self.currentGameQuestions)
        }
        
        
        print("Called!")
        
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
        resetQuestion()
        presentQuestion(questionObjects: currentGameQuestions)
    }
}

