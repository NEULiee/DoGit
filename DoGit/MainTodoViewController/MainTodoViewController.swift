//
//  ViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit
import RealmSwift

class MainTodoViewController: UIViewController {
    
    // let collectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserName()
    }


}

extension MainTodoViewController {
    func checkUserName() {
        if User.shared.name == "" {
            presentSetNameViewControllerModal()
        }
    }
    
    func presentSetNameViewControllerModal() {
        let setNameViewController = SetNameViewController()
        setNameViewController.modalPresentationStyle = .fullScreen
        self.present(setNameViewController, animated: true, completion: nil)
    }
}
