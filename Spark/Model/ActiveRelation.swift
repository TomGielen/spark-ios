//
//  PassedRelation.swift
//  Spark
//
//  Created by Tom Gielen on 03/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

struct ActiveRelation: Decodable {
    var _id: String
    var progress: Int
    var messages: [ActiveRelationMessage]
    var first_user_id: ActiveRelationUser
    var second_user_id: ActiveRelationUser
    var start_date: String
    var status: String
}

struct ActiveRelationUser: Decodable {
    var _id: String
    var firstName: String
    var userImage: String
}

struct ActiveRelationMessage: Decodable {
    var user: ActiveRelationMessageUser
    var _id: String
    var user_id: String
    var user_name: String
    var text: String
    var createdAt: String
    var relation_id: String
}

struct ActiveRelationMessageUser: Decodable {
    var avatar: String
    var id: String
    var name: String
}

