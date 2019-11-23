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
    
    //  Number of extra secounds liflines allowed in game.
    var numberOfExtraSeconds = 1
    
    //  Number of seconds for each question.
    var numberOfSecondsForQuestion = 2
    
    //  Number of questions to be presented in one game.
    //  (IMPORTANT: The number of questions in one game can never
    //  exceed the total number of questions accessible.)
    var numberOfQuestionsInGame = 15
}
