//
//  PassedRelation.swift
//  Spark
//
//  Created by Tom Gielen on 03/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class PassedRelation: NSObject {
    
    var userImage: String?
    var name: String?
    
    var first_user_id: User?
    var second_user_id: User?
    
    var message: Message?
    
}

class User: NSObject {
    var firstName: String?
    var userImage: String?
}

class Message: NSObject {
    var user_id: String?
    var text: String?
}

