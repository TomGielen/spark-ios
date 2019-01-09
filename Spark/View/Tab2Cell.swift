//
//  PassedSparkFeedCell.swift
//  Spark
//
//  Created by Tom Gielen on 04/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class Tab2Cell: BaseCell {
    
    var homeController: UIViewController?

    override func setupViews() {
        super.setupViews()
        setupCard()
    }
    
    func setupCard() {
        let myView = NoSparkCard()
        myView.backgroundColor = UIColor.backgroundGrey
        self.addSubview(myView)
        //self.setupConstraints()
        addConstrainsWithFormat(format: "H:|[v0]|", view: myView)
        addConstrainsWithFormat(format: "V:|[v0]|", view: myView)
        
    }

}














