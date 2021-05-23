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
    
    var url: String?

    private let databaseManager = DatabaseManager()
    
    @IBAction func didTapSaveArticleButton(_ sender: UIButton) {
        if !isArticleInFavorites() {
            databaseManager.saveShortArticle(authorLabel.text ?? "",
                                             updateDateLabel.text ?? "",
                                             titleLabel.text ?? "",
                                             url ?? "")
        } else {
            print("Article already in favorites")
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
}
