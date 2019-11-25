//
//  MusicPlayer.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 25/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Demoiselle", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        }
        catch {
            print("Cannot play the file")
        }
    }
}
