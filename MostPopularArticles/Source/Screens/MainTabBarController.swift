//
//  MainTabBarController.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 26.05.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var controllers: [UINavigationController] = [UINavigationController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewedController = ArticleController()
        viewedController.articleCategories = .viewed
        
        let sharedController = ArticleController()
        sharedController.articleCategories = .shared
        
        let emailedController = ArticleController()
        emailedController.articleCategories = .emailed

        let favoritesController = FavoritesController()
        
        let viewedNavigationController = getNavigationController(viewedController, "Most Viewed", "eyes.inverse", 1)
        let sharedNavigationController = getNavigationController(sharedController, "Most Shared", "square.and.arrow.up.fill", 2)
        let emailedNavigationController = getNavigationController(emailedController, "Most Emailed", "envelope.fill", 3)
        let favoritesNavigationController = getNavigationController(favoritesController, "Favorites", "star.fill", 4)
        
        viewControllers = [viewedNavigationController,
                           sharedNavigationController,
                           emailedNavigationController,
                           favoritesNavigationController]
    }
}

// MARK: - Private methods
private extension MainTabBarController {
    func getNavigationController(_ controller: UIViewController, _ title: String, _ imageSystemName: String, _ tag: Int) -> UINavigationController {
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageSystemName), tag: tag)
        return UINavigationController(rootViewController: controller)
    }
}
