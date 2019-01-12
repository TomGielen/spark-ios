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
    
    var centerCards: Bool = false
    
    let tab1CellId = "tab1CellId"
    let tab2CellId = "tab2CellId"
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
                    updateUser(id: data.value(forKey: "user_id") as! String){
                        (error) in
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
        
      
        // Observers when a context has been saved
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.contextSave(_ :)),
                                               name: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
        
        
    }
    
    @objc func contextSave(_ notification: Notification) {
        let mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        // Retrieves the context saved from the notification
        guard let context = notification.object as? NSManagedObjectContext else { return }
        
        // Checks if the parent context is the main one
        if context.parent === mainManagedObjectContext {
            print("notification....................................")
            // Saves the main context
            mainManagedObjectContext.performAndWait {
                do {
                    try mainManagedObjectContext.save()
                } catch {
                    
                }
            }
        }
    }
    
    
    func checkIfUserIsRegistered() -> Bool {
        let name = UserDefaults.standard.bool(forKey: "FinishedOnboarding")
        if (!name) {
            return false
        } else {
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
        collectionView?.register(Tab1Cell.self, forCellWithReuseIdentifier: tab1CellId)
        collectionView?.register(Tab2Cell.self, forCellWithReuseIdentifier: tab2CellId)
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
    
    override func collectionView(_ collectionView1: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (centerCards == false) {
            collectionView?.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
            centerCards = true
        }
        
        if indexPath.item == 0 {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: tab1CellId, for: indexPath) as! Tab1Cell
            cell.homeController = self
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: tab2CellId, for: indexPath) as! Tab2Cell
            cell.homeController = self
            cell.backgroundColor = UIColor.blue
            return cell
        } else {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: tab3CellId, for: indexPath) as! Tab3Cell
            cell.homeController = self
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        scrollToMenuIndex(menuIndex: 1)
        
        if (HomeController.hasSafeArea) {
            return CGSize.init(width: view.frame.width, height: view.frame.height - 90)
            
        } else {
            return CGSize.init(width: view.frame.width, height: view.frame.height - 65)
        }
    }
    
    func updateUser(id: String, completion:((Error?) -> Void)?) {
        
        let jsonUrlString = String(format: "https://sparklesapi.azurewebsites.net/user/%@", id)
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let singleObject = try JSONDecoder().decode(UpdateUser.self, from: data)
                let json = singleObject
                print(json)
                self.updateCoreDataUser(user: json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    func updateCoreDataUser(user: UpdateUser){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "device_id = %@", user.device_id)
        do {
            let test = try context.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(user.lastName, forKey: "lastName")
            objectUpdate.setValue(user.status, forKey: "status")
            objectUpdate.setValue(user.succes_rate, forKey: "succes_rate")
            objectUpdate.setValue(user.userImage, forKey: "UserImage")
            do{
                try context.save()
                print("updated user data")
            }
            catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
        
        
    }
}



