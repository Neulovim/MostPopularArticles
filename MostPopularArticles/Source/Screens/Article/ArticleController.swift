//
//  ArticleController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 26.05.2021.
//

import UIKit

class ArticleController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var articleCategories: ArticleCategories = ArticleCategories.noCategory
    private let cellIdentifier = "ArticleViewCell"
    private let networkManager = NetworkManager()
    private var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellClassName = String(describing: ArticleViewCell.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: String(describing: cellClassName.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkManager.getArticleData(articleCategories.rawValue,
                                      atricleCompletionHandler: { article, error in
                                        if let article = article {
                                            self.articles = article.results
                                            self.tableView.reloadData()
                                        }
                                      })
    }
}

// MARK: - UITableViewController
extension ArticleController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleViewCell else { return ArticleViewCell() }
        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.updateDateLabel.text = articles[indexPath.row].updated
        cell.authorLabel.text = articles[indexPath.row].byline
        cell.url = articles[indexPath.row].url
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ArticleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkManager.openURL(articles[indexPath.row].url)
    }
}
