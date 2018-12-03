//
//  ViewController.swift
//  Spark
//
//  Created by Tom Gielen on 02/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

struct SingleObject: Decodable {
    let data: [Data]
}

struct Data: Decodable {
    let status: String
    let _id: String
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var passedRelations: [PassedRelation] = {
        var firstMessage = Message()
        firstMessage.text = "Hallo, ik vindt jou leuk"
        
        var firstRelation = PassedRelation()
        firstRelation.name = "Rick"
        firstRelation.userImage = "bram"
        firstRelation.message = firstMessage
        return [firstRelation]
    }()
    
    func fetchPassedRelations() {
        
        // Proberen database connectie te maken
        
//        let jsonUrlString = "https://sparklesapi.azurewebsites.net/relation/passed_relation/5bf6daf8f9cd9b0038ee18e2"
//        guard let url = URL(string: jsonUrlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            guard let data = data else { return }
//
//
//            do {
//
//                let singleObject = try JSONDecoder().decode(SingleObject.self, from: data)
//
//
//                for dictionary in singleObject.data as! [[String: AnyObject]] {
//                    print(dictionary["status"])
//                }
//            } catch let jsonErr {
//                print("Error serializing json:", jsonErr)
//            }
//
//
//
//            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPassedRelations()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(passedSparkCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        
        setupMenuBar()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", view: menuBar)
        view.addConstrainsWithFormat(format: "V:[v0(65)]|", view: menuBar)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passedRelations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! passedSparkCell
        
        cell.passedRelation = passedRelations[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}



