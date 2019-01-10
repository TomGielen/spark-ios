//
//  User.swift
//  Spark
//
//  Created by Tom Gielen on 10/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import MessengerKit

struct User: MSGUser {
    
    var displayName: String
    
    var avatar: UIImage?
    
    var avatarUrl: URL?
    
    var isSender: Bool
    
}
