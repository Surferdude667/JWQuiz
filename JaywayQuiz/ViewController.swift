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
    var timer = Timer()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabel: [UIButton]!
    
    //  GAME CONFIGURATION (IMPORTANT: The number of questions in one game can never exceed the total number of questions accessible.)
    func configureAndPlay(startGame: Bool) {
        currentGameQuestions = Question.prepareQuestionsForGame(questionObjects: questionArray, numberOfQuestionsInGame: 3)
        
        if startGame {
            presentQuestion(questionObjects: currentGameQuestions)
        }
    }
    
    
    //  Presents a new question and marks the question as .used in original data.
    func presentQuestion(questionObjects: [Question]) {
        activeButtons(true)
        let currentQuestion = questionObjects[0]
        
        answerLabel[0].setTitle(currentQuestion.answers[0], for: .normal)
        answerLabel[1].setTitle(currentQuestion.answers[1], for: .normal)
        answerLabel[2].setTitle(currentQuestion.answers[2], for: .normal)
        answerLabel[3].setTitle(currentQuestion.answers[3], for: .normal)
        
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
    
    func activeButtons(_ trueOrFalse: Bool) {
        answerLabel[0].isUserInteractionEnabled = trueOrFalse
        answerLabel[1].isUserInteractionEnabled = trueOrFalse
        answerLabel[2].isUserInteractionEnabled = trueOrFalse
        answerLabel[3].isUserInteractionEnabled = trueOrFalse
    }
    
    func presentNextQuestion() {
        activeButtons(false)
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.removeAskedQuestion()
            
            self.answerLabel[0].tintColor = .systemBlue
            self.answerLabel[1].tintColor = .systemBlue
            self.answerLabel[2].tintColor = .systemBlue
            self.answerLabel[3].tintColor = .systemBlue
            
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
