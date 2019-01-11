//
//  NoSparkCard.swift
//  Spark
//
//  Created by issd on 08/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class RelationCard: UIView {
    //we use lazy properties for each view
    lazy var card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.shadowGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        //        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        //        view.layer.shadowOpacity = 2
        //        view.layer.shadowOffset.width = 0
        //        view.layer.shadowOffset.height = 1
        //        view.layer.shadowRadius = 4
        return view
    }()
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        getRelation()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        getRelation()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .white
        addSubview(card)
        setupActions()
        
        addConstrainsWithFormat(format: "H:|-32-[v0]-32-|", view: card)
        addConstrainsWithFormat(format: "V:|-8-[v0]-8-|", view: card)
    }
    
    private func setupActions() {    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return false
    }
    
    func getRelation(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if let id = data.value(forKey: "user_id") as? String {
                    let jsonUrlString = String(format: "https://sparklesapi.azurewebsites.net/relation/active_relation/%@", id )
                    
                    guard let url = URL(string: jsonUrlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, err) in
                        guard let data = data else { return }
                        do {
                            let singleObject = try JSONDecoder().decode(ActiveRelation.self, from: data)
                            let json = singleObject
                            print(json)
                        } catch let jsonErr {
                            print("Error serializing json:", jsonErr)
                        }
                        }.resume()
                }
            }
        } catch {
            print("Failed")
        }
    }
}

let RelationCardView = RelationCard()
