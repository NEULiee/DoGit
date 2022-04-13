//
//  ViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit
import RealmSwift

class MainTodoViewController: UIViewController {
    
    let realm = try! Realm()
    
    let nameLabel = UILabel()
    let addRepositoryButton = UIButton()
    let menuButton = UIButton()
    // let collectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addGuideMentLabel()
        
        realmLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserName()
    }


}

extension MainTodoViewController {
    
    // MARK: - Realm
    func realmLocation() {
        print(#function)
        print(realm.configuration.fileURL!)
        print(realm.configuration.schemaVersion)
        print("=========================")
    }
    
    // MARK: - Method
    func setUserName() {
        nameLabel.text = "UserName"
    }
    
    func checkUserName() {
        let result = realm.objects(User.self)
        if result.count == 0 {
            presentSetNameViewControllerModal()
        } else {
            guard let user = result.first else { return }
            nameLabel.text = user.name
        }
    }
    
    func presentSetNameViewControllerModal() {
        let setNameViewController = SetNameViewController()
        setNameViewController.modalPresentationStyle = .fullScreen
        self.present(setNameViewController, animated: true, completion: nil)
    }
}
