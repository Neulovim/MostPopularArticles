//
//  DatabaseManager.swift
//  MostPopularArticles
//
//  Created by Aleksandr on 23.05.2021.
//

import CoreData
import UIKit

class DatabaseManager {
    
    private static var shortArticles: [NSManagedObject] = []
    private let entityName = "ShortArticle"
    
    init() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            DatabaseManager.shortArticles = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveShortArticle(_ author: String, _ date: String, _ title: String, _ url: String) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        guard let entity =
                NSEntityDescription.entity(forEntityName: entityName,
                                           in: managedContext) else {return}
        let data = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        data.setValue(author, forKeyPath: "author")
        data.setValue(date, forKeyPath: "date")
        data.setValue(title, forKeyPath: "title")
        data.setValue(url, forKeyPath: "url")
        do {
            try managedContext.save()
            DatabaseManager.shortArticles.append(data)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getShortArticles() -> [NSManagedObject] {
        return DatabaseManager.shortArticles
    }
}
