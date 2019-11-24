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
    @IBOutlet weak var fastestAnswertimeLabel: UILabel!
    @IBOutlet weak var slowestAnswertimeLabel: UILabel!
    @IBOutlet weak var lifelinesUsedLabel: UILabel!
    
    //  SHARE RESULT - Maybe?
    
    func calculateTimes() {
        // Calculate times.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let results = resultPack {
            correctAnswersLabel.text = "Correct: \(results.correctAnswers)"
            wrongAnswersLabel.text = "Wrong: \(results.wrongAnswers)"
            unanswerdAnswersLabel.text = "Unanswerd: \(results.unansweredAnswers)"
            lifelinesUsedLabel.text = "Lifelines used: \(results.lifelinesUsed)"
        }
        
        print(resultPack!.answerTime)
        
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
