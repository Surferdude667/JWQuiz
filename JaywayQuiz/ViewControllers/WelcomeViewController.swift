//
//  WelcomeViewController.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 22/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var startGameButton: SpringButton!
    
    @objc func activatePlayButton() {
        DispatchQueue.main.async {
            self.startGameButton.alpha = 1.0
            self.startGameButton.isUserInteractionEnabled = true
            self.startGameButton.animation = "pop"
            self.startGameButton.curve = "easeInOut"
            self.startGameButton.duration = 1.0
            self.startGameButton.damping = 1.0
            self.startGameButton.velocity = 0.0
            self.startGameButton.animate()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        startGameButton.isUserInteractionEnabled = false
        startGameButton.alpha = 0.5
        
        notificationCenter.addObserver(self, selector: #selector(activatePlayButton), name: Notification.Name("QuestionDataLoaded"), object: nil)
        
        DataFetch.fetchQuestion()
        MusicHelper.sharedHelper.playBackgroundMusic()
    }
    
    
    
    @IBAction func startGameButton(_ sender: Any) {
        performSegue(withIdentifier: "presentGame", sender: self)
    }
}
