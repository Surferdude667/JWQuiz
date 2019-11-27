//
//  JSONParser.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 23/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit

let notificationCenter = NotificationCenter.default
var questionArray = [Question]()

struct DataFetch: Codable {
    let questionID: Int
    let questionString: String
    let questionImage: String
    let answers: [String]
    let correctAnswer: String
    
    static func fetchQuestion()  {
        if let url = URL(string: "https://bjornlau.com/API/questions_final.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode([DataFetch].self, from: data)
                        
                        for i in 0..<result.count {
                            questionArray.append(Question(questionID: result[i].questionID,
                                                          questionString: result[i].questionString,
                                                          questionImage: result[i].questionImage,
                                                          answers: result[i].answers,
                                                          correctAnswer: result[i].correctAnswer))
                            
                        }
                        notificationCenter.post(name: Notification.Name("QuestionDataLoaded"), object: nil)
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
    static func fetchImage(url: String, CompletionHandler: @escaping (UIImage?) -> Void) {
        let url = URL(string: "https://bjornlau.com/\(url)")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                if let image = UIImage(data: data) {
                    CompletionHandler(image)
                }
            }
        })
        task.resume()
    }
    
}
