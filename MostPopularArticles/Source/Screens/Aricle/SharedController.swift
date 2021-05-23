//
//  SharedController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import UIKit

class SharedController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let cellIdentifier = "ArticleViewCell"
    private let networkManager = NetworkManager()
    private var shareds = [Result]()    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellClassName = String(describing: ArticleViewCell.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: String(describing: cellClassName.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setShareds()
        tableView.reloadData()
    }
}

// MARK: - UITableViewController
extension SharedController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shareds.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleViewCell else { return ArticleViewCell() }
    
    cell.titleLabel.text = shareds[indexPath.row].title
    cell.updateDateLabel.text = shareds[indexPath.row].updated
    cell.authorLabel.text = shareds[indexPath.row].byline
    cell.url = shareds[indexPath.row].url
    return cell
    }
}

// MARK: - UITableViewDelegate
extension SharedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkManager.openURL(shareds[indexPath.row].url)
    }
}

// MARK: - Private methods
private extension SharedController {
    func setShareds() {
        networkManager.getArticleData(ArticleCategorys.shared.rawValue,
                                      atricleCompletionHandler: { article, error in
                    if let article = article {
                        self.shareds = article.results
                    }
                })
    }
}
