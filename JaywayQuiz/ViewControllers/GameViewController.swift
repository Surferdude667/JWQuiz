//
//  ViewController.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 19/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//


import UIKit

class GameViewController: UIViewController {
    
    var questionsInCurrentGame = [Question]()
    var currentPresentedQuestion: Question!
    var currentCorrectAnswer: String?
    var currentGameTime: Double!
    
    var breakTimer = Timer()
    var questionTimer = Timer()

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabel: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fiftyFiftyLabel: UIButton!
    @IBOutlet weak var extraSecondsLabel: UIButton!
    @IBOutlet weak var questionImageLabel: UIImageView!
    
    //  CONFIGURE & PLAY - Happy times! <:)
    func configureAndPlay() {
        config = Configuration.init()
        questionsInCurrentGame = Question.prepareQuestionsForGame(questionObjects: questionArray)
        Result.resetResult()
        presentQuestion()
    }
    
    //  Capture result before segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Result.captureResult()
    }
    
    //  Disabels half of the answers - but only 2 that is wrong.
    //  50/50 only works with an even number of answers.
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
        }
    }
    
    
    //  Start question timer.
    func startTimer() {
        questionTimer.invalidate()
        timeLabel.text = "\(config.numberOfMillisecondsForQuestion)"
        currentGameTime = config.numberOfMillisecondsForQuestion - 1.0
        questionTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    //  Update game time label.
    @objc func updateTime() {
        let msToS = currentGameTime / 1000
        let oneDigitFormat = String(format: "%.1f", msToS)
        timeLabel.text = "\(oneDigitFormat)"

        if currentGameTime != 0.0 {
            currentGameTime! -= 1.0
        } else {
            questionTimer.invalidate()
            timeLabel.text = "Bunkers!"
            resutlUnanswered += 1
            presentNextQuestion()
            print("TIME PASSED! Moving on...")
        }
        
        if currentGameTime < 5000 {
            extraSecondsLabel.tintColor = UIColor.orange
        }
        
        if currentGameTime < config.numberOfMillisecondsForQuestion - config.numberOfPlusMiliseconds  {
            extraSecondsLabel.tintColor = UIColor.orange
        }
        
        if currentGameTime < config.numberOfMsLeftToActivateFiftyFifty {
            fiftyFiftyLabel.tintColor = UIColor.orange
        }
    }
    
    //  Resets the controls when a new question is presented.
    func resetControls() {
        startTimer()
        activeButtons(true)
        questionImageLabel.image = nil
        
        for i in 0..<self.answerLabel.count {
            self.answerLabel[i].tintColor = .systemBlue
        }
        
        if config.numberOfFiftyFifty != 0 {
            fiftyFiftyLabel.isHidden = false
        }
        
        if config.numberOfExtraSeconds != 0 {
            extraSecondsLabel.isHidden = false
        }
    }
    
    
    //  Presents a new question and marks the question as .used in original data.
    func presentQuestion() {
        currentPresentedQuestion = questionsInCurrentGame[0]
        currentCorrectAnswer = currentPresentedQuestion.correctAnswer
        Question.markQuestionsAsUsed(questionToRemove: currentPresentedQuestion)
        resetControls()
        
        //  Sets the labels to the current answers.
        for i in 0..<answerLabel.count {
            answerLabel[i].setTitle(currentPresentedQuestion.answers[i], for: .normal)
        }
        
        //  Fetches images from server.
        if currentPresentedQuestion.questionImage.isEmpty {
        } else {
            let url = URL(string: "https://bjornlau.com\(currentPresentedQuestion.questionImage)")!
            self.questionImageLabel.fetchImage(from: url)
        }
        questionLabel.text = currentPresentedQuestion.questionString
    }
    
    //  Remove the answer from the current game list.
    func removeAskedQuestion() {
        if questionsInCurrentGame.count >= 1 {
            questionsInCurrentGame.remove(at: 0)
        }
    }
    
    //  Enables or disables buttons. (Active: true, Disabled: false)
    func activeButtons(_ trueOrFalse: Bool) {
        for i in 0..<answerLabel.count {
            answerLabel[i].isUserInteractionEnabled = trueOrFalse
        }
    }
    
    //  Fires the next question.
    func presentNextQuestion() {
        activeButtons(false)
        
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.removeAskedQuestion()
            resultTime.append(self.currentGameTime)
            
            if self.questionsInCurrentGame.count != 0 {
                self.presentQuestion()
            } else if self.questionsInCurrentGame.count == 0 {
                self.questionLabel.text = "Game is over!"
            }
        }
    }
    
    //  Checks if the answer selected is correct.
    func checkAnswer(answer: String) -> Bool {
        if answer == currentCorrectAnswer {
            print("Correct answer!")
            return true
        } else {
            print("Wrong answer!")
            return false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAndPlay()
    }
    
    
    //  ----------- ACTIONS -----------
    
    @IBAction func seeResultButton(_ sender: Any) {
        self.performSegue(withIdentifier: "presentResult", sender: self)
    }
    
    
    @IBAction func extraSecondsButton(_ sender: UIButton) {
        sender.isHidden = true
        resultLifelinesUsed += 1
        
        if config.numberOfExtraSeconds > 0 {
            config.numberOfExtraSeconds -= 1
            currentGameTime += config.numberOfPlusMiliseconds
        } else {
            print("+10 already used")
        }
    }
    
    @IBAction func fiftyFiftyButton(_ sender: UIButton) {
        sender.isHidden = true
        resultLifelinesUsed += 1
        
        if config.numberOfFiftyFifty > 0 {
            fiftyFifty()
            config.numberOfFiftyFifty -= 1
        } else {
            print("50/50 already used")
        }
    }
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        questionTimer.invalidate()
        presentNextQuestion()
        
        if let buttonTitle = sender.title(for: .normal) {
            if checkAnswer(answer: buttonTitle) {
                sender.tintColor = UIColor.green
                resultCorrectAnswer += 1
            } else {
                sender.tintColor = UIColor.red
                resultWrongAnswer += 1
            }
        }
    }
}
