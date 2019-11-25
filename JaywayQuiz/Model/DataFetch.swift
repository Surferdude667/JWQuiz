//
//  JSONParser.swift
//  JaywayQuiz
//
//  Created by Bjørn Lau Jørgensen on 23/11/2019.
//  Copyright © 2019 Bjørn Lau Jørgensen. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func fetchImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}

var questionArray = [Question]()

struct DataFetch: Codable {
    let questionID: Int
    let questionString: String
    let questionImage: String
    let answers: [String]
    let correctAnswer: String
    
    static func fetchQuestionData()  {
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
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
}
