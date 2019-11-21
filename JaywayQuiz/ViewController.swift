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
    var currentGameTime: Int!
    var numberOfAllowedFiftyFifty: Int!
    var numberOfAllowedPlus10: Int!
    var numberOfSecondsBetweenQuestions: Int!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabel: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fiftyFiftyLabel: UIButton!
    @IBOutlet weak var extraSecondsLabel: UIButton!
    
    //  GAME CONFIGURATION (IMPORTANT: The number of questions in one game can never exceed the total number of questions accessible.)
    func configureAndPlay(startGame: Bool, questionsInGame: Int, numberOfFiftyFifty: Int, numberOfPlus10: Int, secondsBetweenQuestions: Int) {
        currentGameQuestions = Question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: questionsInGame)
        numberOfAllowedFiftyFifty = numberOfFiftyFifty
        numberOfAllowedPlus10 = numberOfPlus10
        numberOfSecondsBetweenQuestions = secondsBetweenQuestions
        
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
                
                for i in wrongAnswers {
                    answerLabel[i].tintColor = UIColor.black
                    answerLabel[i].isUserInteractionEnabled = false
                }
            }
        } else {
            print("50/50 only works with an even number of answers.")
        }
    }
    
    
    //  Start Game Timer!
    func startTimer() {
        gameTimer.invalidate()
        timeLabel.text = "\(numberOfSecondsBetweenQuestions!)"
        currentGameTime = numberOfSecondsBetweenQuestions! - 1
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
    
    func resetControls() {
        startTimer()
        activeButtons(true)
        
        for i in 0..<self.answerLabel.count {
            self.answerLabel[i].tintColor = .systemBlue
        }
        
        if numberOfAllowedFiftyFifty != 0 {
            fiftyFiftyLabel.isHidden = false
        }
        
        if numberOfAllowedPlus10 != 0 {
            extraSecondsLabel.isHidden = false
        }
    }
    
    //  Presents a new question and marks the question as .used in original data.
    func presentQuestion(questionObjects: [Question]) {
        let currentQuestion = questionObjects[0]
        resetControls()
        
        //  Sets the labels to the current answers
        for i in 0..<answerLabel.count {
            answerLabel[i].setTitle(currentQuestion.answers[i], for: .normal)
        }
        
        questionLabel.text = currentQuestion.questionString
        currentCorrectAnswer = currentQuestion.correctAnswer
        
        //  MARKS THE QUESTION THAT HAVE BEEN PRESENTED IN THIS ROUND AS .USED IN ORIGINAL DATA.
        if let index = questionArray.firstIndex(where: { $0.questionID == currentQuestion.questionID }) {
            questionArray[index].isQuestionUsed = .used
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
        configureAndPlay(startGame: true, questionsInGame: 10, numberOfFiftyFifty: 1, numberOfPlus10: 1, secondsBetweenQuestions: 20)
    }
    
    @IBAction func newGame(_ sender: Any) {
        configureAndPlay(startGame: true, questionsInGame: 10, numberOfFiftyFifty: 1, numberOfPlus10: 1, secondsBetweenQuestions: 20)
    }
    
    
    @IBAction func extraSecondsButton(_ sender: UIButton) {
        sender.isHidden = true
        
        if numberOfAllowedPlus10 > 0 {
            numberOfAllowedPlus10 -= 1
            currentGameTime += 10
        } else {
            print("+10 already used")
        }
    }
    
    @IBAction func fiftyFiftyButton(_ sender: UIButton) {
        sender.isHidden = true
        
        if numberOfAllowedFiftyFifty! > 0 {
            fiftyFifty()
            numberOfAllowedFiftyFifty! -= 1
        } else {
            print("50/50 already used")
        }
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
