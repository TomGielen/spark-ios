//
//  ApiService.swift
//  Spark
//
//  Created by Tom Gielen on 04/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchPassedRelations(completion: @escaping ([PassedRelation]) -> ()) {
        
        let jsonUrlString = "https://sparklesapi.azurewebsites.net/relation/passed_relation/5bf6daf8f9cd9b0038ee18e2"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            
            do {
                
                let singleObject = try JSONDecoder().decode(SingleObject.self, from: data)
                
                
                let json = singleObject.data
                
                var passedRelations = [PassedRelation]()
                
                for dictionary in json {
                    
                    let passedRelation = PassedRelation()
                    passedRelation.name = dictionary.first_user_id?.firstName
                    passedRelation.userImage = dictionary.first_user_id?.userImage
                    if(dictionary.messages?.count != 0){
                        passedRelation.message = dictionary.messages?[0].text
                    }
                    
                    passedRelations.append(passedRelation)
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        completion(passedRelations)
                    }
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
        
    }
    
    func registerAccount(completion: @escaping ([PassedRelation]) -> ()) {
        
        
    }

    
}
