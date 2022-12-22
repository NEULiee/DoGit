//
//  ViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit
import RealmSwift

final class MainTodoViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: UI Properties
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold32
        label.sizeToFit()
        return label
    }()
    
    let addRepositoryButton = UIButton().doGitButton(systemName: "plus")
    
    let menuButton = UIButton().doGitButton(systemName: "ellipsis")
    
    let guideMentLabel: UILabel = {
        let label = UILabel()
        label.font = .light18
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "오른쪽 위의 +버튼을 눌러\n저장소를 추가해주세요."
        return label
    }()
    
    var todoView = UIView()
    var collectionView: UICollectionView!
    
    // MARK: dataSource
    var dataSource: DataSource!
    
    // MARK: Notification
    let realm = try! Realm()
    var repositoryNotificationToken: NotificationToken!
    var realmRepositories: Results<Repository>!
    
    var todoNotificationToken: NotificationToken!
    var realmTodos: Results<Todo>!
    
    var userNotificationToken: NotificationToken!
    var realmUsers: Results<User>!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirstData()
        configureUI()
        configureCollectionView()
        realmLocation()
        subscribeRealmNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkRepositoriesIsEmpty()
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

    // MARK: - Methods
    func subscribeRealmNotification() {
        repositoryNotification()
        todoNotification()
        userNotification()
    }
    
    func setFirstData() {
        DoGitStore.shared.readRepositoryAll()
        DoGitStore.shared.readTodoAll()
        DoGitStore.shared.readCurrentUser()
    }
    
    func setUserName() {
        if nameLabel.text != DoGitStore.shared.user {
            makeSnapshot()
        }
        nameLabel.text = DoGitStore.shared.user
    }
    
    func setUserNameAfterChangeName() {
        if nameLabel.text != DoGitStore.shared.user {
            DoGitStore.shared.resetDoGitStore()
            DoGitStore.shared.readAll()
            makeSnapshot()
        }
        nameLabel.text = DoGitStore.shared.user
    }
    
    func checkUserName() {
        if DoGitStore.shared.user == "" {
            presentSetNameViewControllerModal()
        } else {
            setUserName()
        }
    }
    
    func checkRepositoriesIsEmpty() {
        if DoGitStore.shared.repositories.isEmpty {
            addGuideMentLabelInTodoView()
        } else {
            addCollectionViewInTodoView()
        }
    }
    
    func presentSetNameViewControllerModal() {
        let setNameViewController = SetNameViewController()
        setNameViewController.modalPresentationStyle = .fullScreen
        self.present(setNameViewController, animated: true, completion: nil)
    }
    
    func presentBottomSheet(repository: Repository) {
        let writeTodoViewController = WriteTodoViewController(repository: repository)
        let bottomSheetViewController = BottomSheetViewController(contentViewController: writeTodoViewController)
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
    
    func presentBottomSheet(todo: Todo) {
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
    
    func configureCollectionView() {
        // 1. collection view configuration
        let listLayout = listLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
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
        DoGitStore.shared.deleteTodo(with: id)
        makeSnapshot()
    }
    
    // MARK: swipe action
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        guard let repository = DoGitStore.shared.repositories.filter({ $0.todos.map { $0.id }.contains(id) }).first else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            if repository.todos.count == 1 {
                self?.showAlert(message: "할일을 모두 삭제하려면 저장소를 제거해주세요.")
            } else {
                self?.deleteTodo(with: id)
            }
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = .backgroundColor
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: 취소선
    func strikeThrough(string: String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: string)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}


// MARK: - extension: UICollectionViewDelegate
extension MainTodoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let selectedItemID = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let todo = DoGitStore.shared.todo(with: selectedItemID)
        presentBottomSheet(todo: todo)
    }
}
