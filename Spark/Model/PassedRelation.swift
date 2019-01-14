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
    
    var first_user_id: RelationUser?
    var second_user_id: RelationUser?
    
    var message: String?
    
}

class RelationUser: NSObject {
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

class MessageObject: Decodable {
    let _id: String?
    let user_id: String?
    let user_name: String?
    let createdAt: String?
    let relation_id: String?
    let text: String?
    
}

class MessageObj: NSObject {
    var _id: String?
    var user_id: String?
    var user_name: String?
    var createdAt: String?
    var relation_id: String?
    var text: String?
    
}


struct SingleObject: Decodable {
    let data: [PassedRelationResponse]
}

struct SingleMessageObject: Decodable {
    let data: [MessageObject]
}

struct matchResponse: Decodable {
    let confirmation: String?
}


