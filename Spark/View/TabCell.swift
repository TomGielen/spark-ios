//
//  PassedSparkFeedCell.swift
//  Spark
//
//  Created by Tom Gielen on 04/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class TabCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: UIViewController?
    
    override func setupViews() {
        super.setupViews()
        setupCard()
        setupConstraints()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! passedSparkCell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func setupConstraints(){
        firstCard.translatesAutoresizingMaskIntoConstraints = true
        firstCard.center = CGPoint(x: bounds.midX, y: bounds.midY)
        firstCard.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
    }
    
    func setupCard() {
        self.addSubview(firstCard)
        self.setupConstraints()
        
       
        
    }
    
    let firstCard: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 530))
        view.backgroundColor = UIColor.backgroundGrey
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.cornerRadius = 22
        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowOffset.width = 0
         view.layer.shadowOffset.height = 1
        view.layer.shadowRadius = 4
        
      //view.addSubview(searchForRelationBtn)
    return view
    }()

    let searchForRelationBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = UIColor.buttonGrey
        button.setTitle("SEARCH FOR A SPARK", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
}














