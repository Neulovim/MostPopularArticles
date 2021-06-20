//
//  NetworkManager.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
    
    private let apiKey = "QwInY3tebA0NCdNUEVUO6oYhglGLpFg1"
    private let baseURL = "https://api.nytimes.com"
    
    func getArticleData(_ category: String, atricleCompletionHandler: @escaping (ArticleEntity?, Error?) -> Void) {
        
        AF.request("\(baseURL)/svc/mostpopular/v2/\(category)/30.json?api-key=\(apiKey)").responseData { response in
            guard let data = response.data else { return }
            do {
                let articleData = try JSONDecoder().decode(ArticleEntity.self, from: data)
                atricleCompletionHandler(articleData, nil)
            } catch let parseError{
                atricleCompletionHandler(nil, parseError)
            }
        }
    }
    
    func openURL(_ link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
