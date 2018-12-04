//
//  passedRelationCell.swift
//  Spark
//
//  Created by Tom Gielen on 03/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class passedSparkCell: BaseCell {
    
    var passedRelation: PassedRelation? {
        didSet {
            nameLabel.text = passedRelation?.name
            
            setupUserImage()
            
            messageTextView.text = passedRelation?.message
        }
    }
    
    func setupUserImage() {
        if let userImageUrl = passedRelation?.userImage {
            
            let url = URL(string: userImageUrl)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data!)
                    }
                }
                
            }.resume()
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "bram")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bram"
        return label
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Hoe gaat het met je moeder?"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        return textView
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        addSubview(separatorView)
        addSubview(nameLabel)
        addSubview(messageTextView)
        
        addConstrainsWithFormat(format: "H:|-32-[v0(60)]-32-|", view: profileImageView)
        addConstrainsWithFormat(format: "V:|-16-[v0(60)]-16-[v1(1)]|", view: profileImageView, separatorView)
        addConstrainsWithFormat(format: "H:|-32-[v0]-32-|", view: separatorView)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .top, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: separatorView, attribute: .right, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nameLabel, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .right, relatedBy: .equal, toItem: separatorView, attribute: .right, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: messageTextView, attribute: .height, relatedBy: .equal, toItem: messageTextView, attribute: .height, multiplier: 0, constant: 20))
    }
}
