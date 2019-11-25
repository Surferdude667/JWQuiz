//
//  WelcomeViewController.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 22/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var startGameButton: SpringButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataFetch.fetchQuestionData()
        
        startGameButton.animation = "pop"
        startGameButton.curve = "easeInOut"
        startGameButton.duration = 1.5
        startGameButton.scaleX = 1.8
        startGameButton.scaleY = 1.8
        startGameButton.rotate = 2.4
        startGameButton.damping = 1.0
        startGameButton.velocity = 0.0
        startGameButton.animate()
        
    }
    
    
    @IBAction func startGameButton(_ sender: Any) {
        performSegue(withIdentifier: "presentGame", sender: self)
    }
}
