//
//  FavoritesController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 23.05.2021.
//

import UIKit
import CoreData

class FavoritesController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let cellIdentifier = "ArticleViewCell"
    private let networkManager = NetworkManager()
    private let databaseManager = DatabaseManager()
    private var favorites: [NSManagedObject] = []
    
    override func loadView() {
        setFavorites()
        
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
        setFavorites()
        tableView.reloadData()
    }
}

// MARK: - UITableViewController
extension FavoritesController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleViewCell else { return ArticleViewCell() }
    
    cell.titleLabel.text = favorites[indexPath.row].value(forKeyPath: "title") as? String
    cell.updateDateLabel.text = favorites[indexPath.row].value(forKeyPath: "date") as? String
    cell.authorLabel.text = favorites[indexPath.row].value(forKeyPath: "author") as? String
    cell.url = favorites[indexPath.row].value(forKeyPath: "url") as? String
    cell.saveArticleButton.isHidden = true
    return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkManager.openURL(favorites[indexPath.row]
                                .value(forKeyPath: "url") as? String ?? "")
    }
}

// MARK: - Private methods
private extension FavoritesController {
    func setFavorites() {
        favorites = databaseManager.getShortArticles()
    }
}
