//
//  ViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit
import RealmSwift

class MainTodoViewController: UIViewController {
    
    // MARK: - Properties
    
    let realm = try! Realm()
    
    let nameLabel = UILabel()
    let addRepositoryButton = UIButton()
    let menuButton = UIButton()
    let guideMentLabel = UILabel()
    
    var todoView = UIView()
    var collectionView: UICollectionView!
    
    // MARK: dataSource
    var dataSource: DataSource!
    var repositories: [Repository] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkRepositoriesCount()
        
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
    
    func checkRepositoriesCount() {
        let repositories = realm.objects(Repository.self)
        if repositories.isEmpty {
            addGuideMentLabelInTodoView()
        } else {
            addCollectionView()
        }
    }
    
    func addCollectionView() {
        // 1. collection view configuration
        let listLayout = listLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
        // UI
        addCollectionViewInTodoView()
        
        // 2. cell registration
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Todo) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        // 3. header registration
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TodoHeader>(elementKind: TodoHeader.elementKind, handler: headerRegistartionHandler)
        dataSource.supplementaryViewProvider = { [unowned self] supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        // 4. update snapshot
        updateSnapshot()
        
        // 5. datasource 적용
        collectionView.dataSource = dataSource
    }
}
