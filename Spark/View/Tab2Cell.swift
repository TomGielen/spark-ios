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
                    setupCard(cardView: RelationCard())
                case "searching":
                    setupCard(cardView: RelationCard())
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

}














