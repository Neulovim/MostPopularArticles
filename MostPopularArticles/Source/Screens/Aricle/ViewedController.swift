//
//  ViewedController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import UIKit

class ViewedController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let cellIdentifier = "ArticleViewCell"
    private let networkManager = NetworkManager()
    private var vieweds = [Result]()
    
    override func loadView() {
        setVieweds()
        
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellClassName = String(describing: ArticleViewCell.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: String(describing: cellClassName.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setVieweds()
        tableView.reloadData()
    }
}

// MARK: - UITableViewController
extension ViewedController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vieweds.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleViewCell else { return ArticleViewCell() }
    
    cell.titleLabel.text = vieweds[indexPath.row].title
    cell.updateDateLabel.text = vieweds[indexPath.row].updated
    cell.authorLabel.text = vieweds[indexPath.row].byline
    cell.url = vieweds[indexPath.row].url
    return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkManager.openURL(vieweds[indexPath.row].url) 
    }
}

// MARK: - Private methods
private extension ViewedController {
    func setVieweds() {
        networkManager.getArticleData(ArticleCategorys.viewed.rawValue,
                                      atricleCompletionHandler: { article, error in
                    if let article = article {
                        self.vieweds = article.results
                    }
                })
    }
}
