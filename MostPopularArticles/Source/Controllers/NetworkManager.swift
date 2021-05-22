//
//  NetworkManager.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import Foundation

class NetworkManager {
    
    private let apiKey = "QwInY3tebA0NCdNUEVUO6oYhglGLpFg1"
    private let baseURL = "https://api.nytimes.com"

    func getArticleData(_ category: String, _ daysCount: String, atricleCompletionHandler: @escaping (Article?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/svc/mostpopular/v2/\(category)/\(daysCount).json?api-key=\(apiKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let articleData = try JSONDecoder().decode(Article.self, from: data)
                atricleCompletionHandler(articleData, nil)
            } catch let parseError{
                atricleCompletionHandler(nil, parseError)
            }
        }
        task.resume()
    }
}
