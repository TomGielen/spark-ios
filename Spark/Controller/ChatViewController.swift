//
//  ChatViewController.swift
//  Spark
//
//  Created by Tom Gielen on 04/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var passedRelation: PassedRelation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let passedRel = passedRelation {
            passedRel
        }

    }
    


}
