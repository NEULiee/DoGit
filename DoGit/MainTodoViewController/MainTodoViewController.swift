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
    var repositoryNotificationToken: NotificationToken!
    var realmRepositories: Results<Repository>!
    
    var todoNotificationToken: NotificationToken!
    var realmTodos: Results<Todo>!
    
    var userNotificationToken: NotificationToken!
    var realmUsers: Results<User>!
    
    let nameLabel = UILabel()
    let addRepositoryButton = UIButton()
    let menuButton = UIButton()
    let guideMentLabel = UILabel()
    
    var todoView = UIView()
    var collectionView: UICollectionView!
    
    // MARK: dataSource
    var dataSource: DataSource!
    var repositories: [Repository] = []
    var todos: [Todo] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // testData()
        
        configureUI()
        configureCollectionView()
        getTodos()
        
        realmLocation()
        
        repositoryNotification()
        todoNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkRepositoriesCount()
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
    
    func testData() {
        //guard let repo = realm.objects(Repository.self).first else { return }
        //print(repo)
        
        let repos = realm.objects(Repository.self)
        
        try! realm.write {
            // repo.todos.append(Todo())
            repos[1].todos.append(Todo())
        }
    }
    
    // MARK: - Method
    func setUserName() {
        let result = realm.objects(User.self)
        guard let user = result.last else { return }
        nameLabel.text = user.name
    }
    
    func checkUserName() {
        let result = realm.objects(User.self)
        if result.count == 0 {
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
    
    func showBottomSheet(repository: Repository) {
        let writeTodoViewController = WriteTodoViewController(repository: repository)
        
        let bottomSheetViewController = BottomSheetViewController(contentViewController: writeTodoViewController)
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
    
    func showBottomSheet(todo: Todo) {
        let writeTodoViewController = WriteTodoViewController(todo: todo)
        
        let bottomSheetViewController = BottomSheetViewController(contentViewController: writeTodoViewController)
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = .mainColor
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func checkRepositoriesCount() {
        let repositories = realm.objects(Repository.self)
        if repositories.isEmpty {
            addGuideMentLabelInTodoView()
        } else {
            addCollectionViewInTodoView()
        }
    }
    
    func getTodos() {
        todos = Array(realm.objects(Todo.self).sorted(byKeyPath: "content"))
    }
    
    func configureCollectionView() {
        // 1. collection view configuration
        let listLayout = listLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
        // UI
        // addCollectionViewInTodoView()
        
        // 2. cell registration
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Todo.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        // 3. header registration
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TodoHeader>(elementKind: TodoHeader.elementKind, handler: headerRegistartionHandler)
        dataSource.supplementaryViewProvider = { [unowned self] supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        // 4. update snapshot
        makeSnapshot()
        
        // 5. datasource 적용
        collectionView.dataSource = dataSource
        
        collectionView.delegate = self
    }
    
    func deleteTodo(with id: Todo.ID) {
        guard let todo = realm.objects(Todo.self).filter({ $0.id == id }).first else { return }
        try! realm.write {
            realm.delete(todo)
        }
        makeSnapshot()
    }
}

extension MainTodoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItemID = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        guard let todo = realm.objects(Todo.self).filter({ $0.id == selectedItemID }).first else { return }
        showBottomSheet(todo: todo)
    }
}
