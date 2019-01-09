//
//  ViewController.swift
//  Spark
//
//  Created by Tom Gielen on 02/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    static var hasSafeArea: Bool {
        guard #available(iOS 11.0, *), let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 24 else {
            return false
        }
        return true
    }
    
    
    let cellId = "cellId"
    let tab3CellId = "tab3CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 20)
        navigationItem.titleView = titleLabel
        
        if (checkIfUserIsRegistered()){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                   
                    var newLoginUser = LoginUser()
                    newLoginUser.firstName = data.value(forKey: "firstName") as? String
                    newLoginUser.device_id = data.value(forKey: "device_id") as? String
                    
                    loginUser(loginUser: newLoginUser) { (error) in
                        if let error = error {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            } catch {
                print("Failed")
            }
        } else {
             toOnboarding()
        }
        
        
        setupCollectionView()
        setupMenuBar()
    }
    
    
    func checkIfUserIsRegistered() -> Bool {
        let name = UserDefaults.standard.bool(forKey: "FinishedOnboarding")
        if(!name){
            return false
        }else{
            return true
        }
    }
    
    func toOnboarding(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "onboarding_nav") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.backgroundGrey
        collectionView?.register(TabCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(Tab3Cell.self, forCellWithReuseIdentifier: tab3CellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 65, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", view: menuBar)
        if (HomeController.hasSafeArea) {
            view.addConstrainsWithFormat(format: "V:[v0(90)]|", view: menuBar)
        } else {
            view.addConstrainsWithFormat(format: "V:[v0(65)]|", view: menuBar)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3 + view.frame.width / 6 - 22
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tab3CellId, for: indexPath) as! Tab3Cell
            cell.homeController = self
            return cell
    
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabCell
        cell.backgroundColor = UIColor.backgroundGrey
        cell.homeController = self

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (HomeController.hasSafeArea) {
            return CGSize.init(width: view.frame.width, height: view.frame.height - 90)

        } else {
            return CGSize.init(width: view.frame.width, height: view.frame.height - 65)
        }
    }
    
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
}



