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
    var currentGameQuestions = [Question]()
    var breakTimer = Timer()
    var gameTimer = Timer()
    var currentGameTime: Int?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabel: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    
    //  GAME CONFIGURATION (IMPORTANT: The number of questions in one game can never exceed the total number of questions accessible.)
    func configureAndPlay(startGame: Bool) {
        currentGameQuestions = Question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: 10)
        
        if startGame {
            presentQuestion(questionObjects: currentGameQuestions)
        }
    }
    
    func fiftyFifty() {
        if answerLabel.count % 2 == 0 {
            var numberOfAnswers = Array(0..<answerLabel.count)
            
            if let indexOfCorrectAnswer = answerLabel.firstIndex(where: { $0.title(for: .normal) == currentCorrectAnswer }) {
                
                numberOfAnswers.remove(at: indexOfCorrectAnswer)
                let randomized = numberOfAnswers.shuffled()
                let wrongAnswers = randomized.prefix(answerLabel.count / 2)
                
                for elements in wrongAnswers {
                    answerLabel[elements].tintColor = UIColor.black
                }
            }
        } else {
            print("50/50 only works with an even number of answers.")
        }
    }
    
    
    
    //  Start game timer from beginning.
    func startTimer() {
        gameTimer.invalidate()
        timeLabel.text = "15"
        currentGameTime = 14
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timeLabel.text = "\(currentGameTime!)"
        
        if currentGameTime != 0 {
            currentGameTime! -= 1
        } else {
            gameTimer.invalidate()
            timeLabel.text = "Bunkers!"
            print("TIME PASSED!")
        }
    }
    
    //  Presents a new question and marks the question as .used in original data.
    func presentQuestion(questionObjects: [Question]) {
        let currentQuestion = questionObjects[0]
        activeButtons(true)
        startTimer()
        
        //  Sets the labels to the current answers
        for i in 0..<answerLabel.count {
            answerLabel[i].setTitle(currentQuestion.answers[i], for: .normal)
        }
        
        questionLabel.text = currentQuestion.questionString
        currentCorrectAnswer = currentQuestion.correctAnswer
        
        //  MARKS THE QUESTION THAT HAVE BEEN PRESENTED IN THIS ROUND AS .USED IN ORIGINAL DATA.
        if let index = questionArray.firstIndex(where: { $0.questionID == currentQuestion.questionID }) {
            questionArray[index].isQuestionUsed = .used
            print(questionArray[index].questionID)
        }
    }
    
    //  Remove the answer from the current game list.
    func removeAskedQuestion() {
        if currentGameQuestions.count >= 1 {
            currentGameQuestions.remove(at: 0)
        }
    }
    
    //  Enables or disables buttons. (Active: true, Disabled: false)
    func activeButtons(_ trueOrFalse: Bool) {
        for i in 0..<answerLabel.count {
            answerLabel[i].isUserInteractionEnabled = trueOrFalse
        }
    }
    
    func presentNextQuestion() {
        activeButtons(false)
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.removeAskedQuestion()
            
            for i in 0..<self.answerLabel.count {
                self.answerLabel[i].tintColor = .systemBlue
            }
            
            if self.currentGameQuestions.count != 0 {
                self.presentQuestion(questionObjects: self.currentGameQuestions)
            } else if self.currentGameQuestions.count == 0 {
                print("Game over")
                self.questionLabel.text = "Game is over!"
            }
        }
    }
    
    func checkAnswer(answer: String) -> Bool {
        presentNextQuestion()
        
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
        configureAndPlay(startGame: true)
    }
    
    @IBAction func newGame(_ sender: Any) {
        configureAndPlay(startGame: true)
    }
    
    
    @IBAction func extraSecondsButton(_ sender: Any) {
        if currentGameTime != nil {
            currentGameTime! += 10
        }
        
    }
    
    @IBAction func fiftyFiftyButton(_ sender: Any) {
        fiftyFifty()
    }
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        gameTimer.invalidate()
        
        if let buttonTitle = sender.title(for: .normal) {
            if checkAnswer(answer: buttonTitle) {
                sender.tintColor = UIColor.green
            } else {
                sender.tintColor = UIColor.red
            }
        }
    }
}
