//
//  ResultViewController.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 22/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var wrongAnswersLabel: UILabel!
    @IBOutlet weak var unanswerdAnswersLabel: UILabel!
    @IBOutlet weak var lifelinesUsedLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let results = resultPack {
            correctAnswersLabel.text = "\(results.correctAnswers)"
            wrongAnswersLabel.text = "\(results.wrongAnswers)"
            unanswerdAnswersLabel.text = "\(results.unansweredAnswers)"
            lifelinesUsedLabel.text = "\(results.lifelinesUsed)/2"
            
            let sum = results.answerTime.reduce(0, +)
            let avg = sum / Double(results.answerTime.count)
            let finalResult =  (config.numberOfMillisecondsForQuestion - avg) / 1000
            
            averageTimeLabel.text = "\(String(format: "%.2f", finalResult))s"
        }
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
