//
//  ViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit
import RealmSwift

class MainTodoViewController: UIViewController {
    
    let nameLabel = UILabel()
    let addRepositoryButton = UIButton()
    let menuButton = UIButton()
    // let collectionView = UICollectionView()

    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserName()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserName()
    }


}

extension MainTodoViewController {
    
    func setUserName() {
        nameLabel.text = User.shared.name
    }
    
    func checkUserName() {
        if User.shared.name == "" {
            presentSetNameViewControllerModal()
        } else {
            setUserName()
        }
    }
    
    func presentSetNameViewControllerModal() {
        let setNameViewController = SetNameViewController()
        setNameViewController.modalPresentationStyle = .fullScreen
        self.present(setNameViewController, animated: true, completion: nil)
    }
}
