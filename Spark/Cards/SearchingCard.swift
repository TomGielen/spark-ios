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

class SearchingCard: UIView {
    //we use lazy properties for each view
    lazy var card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowOffset.width = 0
        view.layer.shadowOffset.height = 1
        view.layer.shadowRadius = 4
        view.addSubview(text)
        return view
    }()
    
    lazy var text: UILabel = {
        let text = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        text.text = "We are finding a spark for you."
        return text
    }()
    
    
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
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
}

let SearchingCardView = SearchingCard()
