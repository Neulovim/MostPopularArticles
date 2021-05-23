//
//  ArticleViewCell.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import UIKit

class ArticleViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var saveArticleButton: UIButton!
    
    var url: String?

    private let databaseManager = DatabaseManager()
    
    @IBAction func didTapSaveArticleButton(_ sender: UIButton) {
        if !isArticleInFavorites() {
            showSaveAlert()
        } else {
            showAlreadySavedAlert()
        }
    }
}

// MARK: - Private methods
private extension ArticleViewCell {
    func isArticleInFavorites() -> Bool {
        let articlesFavorites = databaseManager.getShortArticles()
        for article in articlesFavorites {
            if article.value(forKeyPath: "url") as? String == url {
                return true
            }
        }
        return false
    }
    
    func showSaveAlert() {
        let alert = UIAlertController(title: "Saving",
                                      message: "Add article to favorites?",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {_ in
            self.databaseManager.saveShortArticle(self.authorLabel.text ?? "",
                                                  self.updateDateLabel.text ?? "",
                                                  self.titleLabel.text ?? "",
                                                  self.url ?? "")
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlreadySavedAlert() {
        let alert = UIAlertController(title: "Wow",
                                      message: "Article already in favorites",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .cancel)
        
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
