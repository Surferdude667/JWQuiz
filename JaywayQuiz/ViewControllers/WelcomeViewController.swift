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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataFetch.fetchQuestionData()
        
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        performSegue(withIdentifier: "presentGame", sender: self)
    }
}
