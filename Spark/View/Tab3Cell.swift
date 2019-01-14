//
//  Tab3Cell.swift
//  Spark
//
//  Created by Tom Gielen on 04/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class Tab3Cell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var homeController: UIViewController?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.backgroundGrey
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var passedRelations: [PassedRelation]?
    
    let cellId = "cellId"
    
    func fetchPassedRelations() {
        ApiService.sharedInstance.fetchPassedRelations { (passedRelations: [PassedRelation]) in
            
            self.passedRelations = passedRelations
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchPassedRelations()
        
        addSubview(collectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", view: collectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", view: collectionView)
        backgroundColor = UIColor.backgroundGrey
        collectionView.register(passedSparkCell.self, forCellWithReuseIdentifier: cellId)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passedRelations?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! passedSparkCell
        
        cell.passedRelation = passedRelations?[indexPath.item]
        cell.backgroundColor = UIColor.backgroundGrey
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: frame.width, height: 90)
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! passedSparkCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sparkChatNavController") as! ChatViewController
        vc.relation = cell.passedRelation
        homeController?.show(vc, sender: nil)
    }

}
