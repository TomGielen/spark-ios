//
//  ViewController.swift
//  Spark
//
//  Created by Tom Gielen on 02/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    let cellId = "cellId"
    let tab3CellId = "tab3CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        

        checkIfUserIsloggedin()
        setupCollectionView()
        setupMenuBar()
    }
    
    
    func checkIfUserIsloggedin() {
        let login = false
        
        if(!login){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "onboarding_nav") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(TabCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(Tab3Cell.self, forCellWithReuseIdentifier: tab3CellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", view: menuBar)
        view.addConstrainsWithFormat(format: "V:[v0(65)]|", view: menuBar)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3 + view.frame.width / 6 - 22
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: tab3CellId, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: view.frame.height - 65)
    }

}



