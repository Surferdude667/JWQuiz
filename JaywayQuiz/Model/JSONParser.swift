//
//  JSONParser.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 23/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation

var questionArray = [Question]()

struct JSONParser: Codable {
    let questionID: Int
    let questionString: String
    let questionImage: String
    let answers: [String]
    let correctAnswer: String
    
    static func fetchData() {
        
        if let url = URL(string: "https://bjornlau.com/API/questions.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode([JSONParser].self, from: data)
                        for i in 0..<result.count {
                            questionArray.append(Question(questionID: result[i].questionID,
                                                          questionString: result[i].questionString,
                                                          questionImage: result[i].questionImage,
                                                          answers: result[i].answers,
                                                          correctAnswer: result[i].correctAnswer))
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}




