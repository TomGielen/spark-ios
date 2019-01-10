//
//  PassedSparkFeedCell.swift
//  Spark
//
//  Created by Tom Gielen on 04/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit
import CoreData

class Tab2Cell: BaseCell {
    
    var homeController: UIViewController?

    override func setupViews() {
        super.setupViews()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                switch data.value(forKey: "status") as? String {
                case "no_relation":
                    setupCard(cardView: NoSparkCard())
                case "in_relation":
                    setupCard(cardView: SearchingCard())
                case "searching":
                    setupCard(cardView: SearchingCard())
                default:
                    print("no value in switch statement")
                }
            }
        } catch {
            print("Failed")
        }

    }
    
    func setupCard(cardView: UIView) {
        let view = cardView
        view.backgroundColor = UIColor.backgroundGrey
        self.addSubview(view)
        //self.setupConstraints()
        addConstrainsWithFormat(format: "H:|[v0]|", view: view)
        addConstrainsWithFormat(format: "V:|[v0]|", view: view)
        
    }
    
    // Main context
    let mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    // Observers when a context has been saved
//    NotificationCenter.default.addObserver(self,
//    selector: #selector(self.contextSave(_ :)),
//    name: NSNotification.Name.NSManagedObjectContextDidSave,
//    object: nil)
    
    func contextSave(_ notification: Notification) {
        // Retrieves the context saved from the notification
        guard let context = notification.object as? NSManagedObjectContext else { return }
        // Checks if the parent context is the main one
        if context.parent === mainManagedObjectContext {
            
            // Saves the main context
            mainManagedObjectContext.performAndWait {
                do {
                    try mainManagedObjectContext.save()
                } catch {
                }
            }
        }
    }


}














