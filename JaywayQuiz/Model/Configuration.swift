//
//  Configuration.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 22/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation

var config: Configuration!

//  GAME CONFIGURATION
class Configuration {
    
    //  Number of 50/50 liflines allowed in game.
    var numberOfFiftyFifty = 1
    
    //  The amount of ms left in the game when 50/50 is activated.
    let numberOfMsLeftToActivateFiftyFifty: Double = 13000
    
    //  Number of extra secounds liflines allowed in game.
    var numberOfExtraSeconds = 1
    
    //  Number of extra miliseconds to be added with lifeline.
    //  This may never be higher than the number of seconds for a question.
    //  The difference between the question time and the lifeline plus is when
    //  the lifeline is activated. So if numberOfPlusMiliseconds = 10000 and
    //  numberOfMillisecondsForQuestion = 15000 the lifeline will be activated after 5000 ms.
    let numberOfPlusMiliseconds: Double = 10000
    
    //  Number of seconds for each question.
    let numberOfMillisecondsForQuestion: Double = 15000
    
    //  Number of questions to be presented in one game.
    //  (IMPORTANT: The number of questions in one game can never
    //  exceed the total number of questions accessible.)
    let numberOfQuestionsInGame = 4
}
