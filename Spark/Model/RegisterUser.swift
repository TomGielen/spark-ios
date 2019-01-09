//
//  RegisterUser.swift
//  Spark
//
//  Created by issd on 28/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import Foundation

import UIKit

struct RegisterUser: Codable {
    var device_id: String?
    var gender: String?
    var preference: String?
    var firstName: String?
    var userImage: String?
    var date_of_birth: Date?
}

struct RegisterUserResult: Decodable {
    var result : RegisterUserResponse
}

struct RegisterUserResponse: Decodable {
    var _id: String
    var device_id: String
    var gender: String
    var preference: String
    var firstName: String
    var userImage: String
    var date_of_birth: String
    var lastName: String
    var status: String
    var succes_rate: Int
    var language: String
}

struct UpdateUser: Decodable {
    var device_id: String
    var userImage: String
    var lastName: String
    var status: String
    var succes_rate: Int
}
