//
//  EmailedController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 22.05.2021.
//

import UIKit

class EmailedController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let cellIdentifier = "ArticleViewCell"
    private let networkManager = NetworkManager()
    private var emaileds = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellClassName = String(describing: ArticleViewCell.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: String(describing: cellClassName.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setEmaileds()
        tableView.reloadData()
    }
}

// MARK: - UITableViewController
extension EmailedController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return emaileds.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleViewCell else { return ArticleViewCell() }
    
    cell.titleLabel.text = emaileds[indexPath.row].title
    cell.updateDateLabel.text = emaileds[indexPath.row].updated
    cell.authorLabel.text = emaileds[indexPath.row].byline
    cell.url = emaileds[indexPath.row].url
    return cell
    }
}

// MARK: - UITableViewDelegate
extension EmailedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkManager.openURL(emaileds[indexPath.row].url)
    }
}

// MARK: - Private methods
private extension EmailedController {
    func setEmaileds() {
        networkManager.getArticleData(ArticleCategorys.emailed.rawValue,
                                      atricleCompletionHandler: { article, error in
                    if let article = article {
                        self.emaileds = article.results
                    }
                })
    }
}
