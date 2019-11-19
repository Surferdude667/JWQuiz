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
    
    func setupQuestions(questionObjects: [question]) {
        let randomQuestion = questionObjects.randomElement()
        
        answerLabel0.setTitle(randomQuestion?.answers[0], for: .normal)
        answerLabel1.setTitle(randomQuestion?.answers[1], for: .normal)
        answerLabel2.setTitle(randomQuestion?.answers[2], for: .normal)
        answerLabel3.setTitle(randomQuestion?.answers[3], for: .normal)
        questionLabel.text = randomQuestion?.questionString
        currentCorrectAnswer = randomQuestion?.correctAnswer
    }
    
    func checkAnswer(answer: String) {
        if answer == currentCorrectAnswer {
            print("Correct answer!")
        } else {
            print("Wrong answer!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions(questionObjects: questionArray)
    }
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            checkAnswer(answer: buttonTitle)
        }
        
    }
    
}

