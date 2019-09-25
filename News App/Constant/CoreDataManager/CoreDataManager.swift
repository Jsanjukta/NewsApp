//
//  CoreDataManager.swift
//  News App
//
//  Created by Krishna on 26/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit
import CoreData

var appDelegate = AppDelegate()

class CoreDataManager: NSObject {
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    // MARK: - Singleton -
    class var sharedInstance:CoreDataManager {
        
        struct Static{
            static let _instance = CoreDataManager()
        }
        
        return Static._instance
    }
    
    func fetchNews() -> Array<Any> {
        DispatchQueue.main.async {
            appDelegate = UIApplication.shared.delegate! as! AppDelegate
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY.news)
        var results : Array<Any>?
        do {
            let resultsTemp =
                try managedContext.fetch(fetchRequest)
            results = Array()
            results = resultsTemp
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            
            return Array()
        }
        
        return results!
    }
    
    func insertNews(withTitle title: String , withDesc desc: String) -> Bool {
        
        DispatchQueue.main.async {
            appDelegate = UIApplication.shared.delegate! as! AppDelegate
        }
        
        let entity = NSEntityDescription.entity(forEntityName: ENTITY.news, in: managedContext)
        let newNews = NSManagedObject(entity: entity!, insertInto: managedContext)
        newNews.setValue(desc, forKey: "desc")
        newNews.setValue(title, forKey: "title")
        do {
            try managedContext.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
}
