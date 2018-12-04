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
    
    var message: String?
    
}

class User: NSObject {
    var firstName: String?
    var userImage: String?
}

class Message: NSObject {
    var user_id: String?
    var text: String?
}

struct PassedRelationResponse: Decodable {
    
    let _id: String?
    let status: String?
    
    let first_user_id: UserResponse?
    let second_user_id: UserResponse?
    
    let messages: [MessageResponse]?
    
}

class UserResponse: Decodable {
    let firstName: String?
    let userImage: String?
}

class MessageResponse: Decodable {
    let user_id: String?
    let text: String?
}
