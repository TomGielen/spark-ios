//
//  LoginService.swift
//  Spark
//
//  Created by Tom Gielen on 09/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import UIKit

func loginUser(loginUser : LoginUser ,completion:((Error?) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "sparklesapi.azurewebsites.net"
    urlComponents.path = "/user/login"
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(loginUser)
        // ... and set our request's HTTP body
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        completion?(error)
    }
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            completion?(responseError!)
            return
        }
        
        // APIs usually respond with the data you just sent in your POST request
        if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
            print("response: ", utf8Representation)
            //    do{
            //    let user = try JSONDecoder().decode(RegisterUserResult.self, from: data)
            //    print("DE NEIWUE USERRRTT   ", user.result.date_of_birth as Any)
            //    //
            //    } catch let error {
            //    print(error)
            //    }
        } else {
            print("no readable data received in response")
        }
    }
    task.resume()
}
