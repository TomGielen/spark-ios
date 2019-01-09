//
//  ChatViewController.swift
//  Spark
//
//  Created by Tom Gielen on 04/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//


import UIKit
import MessengerKit


class ChatViewController: MSGMessengerViewController {

    var passedRelation: PassedRelation?
    
//    // Users in the chat
//
//    var steve = UserMG(displayName: "Steve", avatar: #imageLiteral(resourceName: "steve228uk"), avatarUrl: nil, isSender: true)
//
//    var tim = UserMG(displayName: "Tim", avatar: #imageLiteral(resourceName: "timi"), avatarUrl: nil, isSender: false)
//
//    lazy var messages: [[MSGMessage]] = {
//        return [
//            [
//                MSGMessage(id: 1, body: .emoji("🐙💦🔫"), user: tim, sentAt: Date()),
//                ],
//            [
//                MSGMessage(id: 2, body: .text("Yeah sure, gimme 5"), user: steve, sentAt: Date()),
//                MSGMessage(id: 3, body: .text("Okay ready when you are"), user: steve, sentAt: Date())
//            ]
//        ]
//    }()
    
    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dataSource? = self as! MSGDataSource
        
        if let passedRel = passedRelation {
             navigationItem.title = passedRel.name
        }
        
        
        
}

    }

}

// MARK: - MSGDataSource

//extension ViewController: MSGDataSource {
//
//    func numberOfSections() -> Int {
//        return messages.count
//    }
//
//    func numberOfMessages(in section: Int) -> Int {
//        return messages[section].count
//    }
//
//    func message(for indexPath: IndexPath) -> MSGMessage {
//        return messages[indexPath.section][indexPath.item]
//    }
//
//    func footerTitle(for section: Int) -> String? {
//        return "Just now"
//    }
//
//    func headerTitle(for section: Int) -> String? {
//        return messages[section].first?.user.displayName
//    }
//
//}

/// Objects representing a user within MessengerKit
/// Must conform to this protocol.
//public protocol MSGUser {
//    
//    /// The name that will be displayed on the cell
//    var displayName: String { get }
//    
//    /// The avatar for the user.
//    /// This is optional as an `avatarUrl` can be provided instead.
//    var avatar: UIImage? { get set }
//    
//    /// The URL for an avatar.
//    /// This is optional as an `avatar` can be provided instead.
//    var avatarUrl: URL? { get set }
//    
//    /// Whether this user is the one sending messages.
//    /// This is used to determine which bubble is rendered.
//    var isSender: Bool { get }
//    
//}
//
//
//struct UserMG: MSGUser {
//    
//    var displayName: String
//    
//    var avatar: UIImage?
//    
//    var avatarUrl: URL?
//    
//    var isSender: Bool
//    
//}
