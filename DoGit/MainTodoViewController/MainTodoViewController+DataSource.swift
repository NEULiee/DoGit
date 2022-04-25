//
//  MainTodoViewController+DataSource.swift
//  DoGit
//
//  Created by neuli on 2022/04/09.
//

import UIKit

extension MainTodoViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Repository.ID, Todo.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Repository.ID, Todo.ID>
    
    func getRepositories() {
        repositories = TodoRepositoryStore.shared.readTodoAll()
    }
    
    func makeSnapshot() {
        getRepositories()
        getTodos()
        
        var snapshot = Snapshot()
        snapshot.appendSections(repositories.map { $0.id })
        
        for repository in repositories {
            snapshot.appendItems(Array(repository.todos.map { $0.id }), toSection: repository.id)
        }
        
        dataSource.apply(snapshot)
    }
    
    func updateSnapshot(with id: [Todo.ID]) {
        getRepositories()
        getTodos()

        var snapshot = dataSource.snapshot()
        if id.isEmpty {
            snapshot.reconfigureItems(todos.map { $0.id })
        } else {
            snapshot.reconfigureItems(id)
        }

        dataSource.apply(snapshot)
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfiguration.headerMode = .supplementary
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        layoutConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, todoID: Todo.ID) {
        var contentConfiguration = cell.defaultContentConfiguration()
        let todo = todos[todos.indexOfTodo(with: todoID)]
        contentConfiguration.text = todo.content
        contentConfiguration.textProperties.lineBreakMode = .byCharWrapping
        contentConfiguration.textProperties.font = UIFont.Font.regular14
        contentConfiguration.textProperties.color = .fontColor
        cell.backgroundColor = .backgroundColor
        cell.contentConfiguration = contentConfiguration
        let background: UIView = {
            let view = UIView()
            view.backgroundColor = .backgroundColor
            return view
        }()
        cell.backgroundView = background
        let selectedBackground: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
        cell.selectedBackgroundView = selectedBackground
        
        let doneButtonConfiguration = doneButtonConfiguration(for: todo)
        cell.accessories = [.customView(configuration: doneButtonConfiguration)]
    }
    
    private func doneButtonConfiguration(for todo: Todo) -> UICellAccessory.CustomViewConfiguration {
        let tintColor = todo.isDone ? UIColor.mainColor : UIColor.systemGray4
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "square.fill", withConfiguration: symbolConfiguration)
        
        let button = TodoDoneButton()
        button.addTarget(self, action: #selector(touchUpInsideDoneButton(_:)), for: .touchUpInside)
        button.todo = todo
        button.tintColor = tintColor
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func headerRegistartionHandler(headerView: TodoHeader, elementKind: String, indexPath: IndexPath) {
        let headerItemID = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let headerItem = repository(with: headerItemID)
        headerView.backgroundColor = .backgroundColor
        headerView.repositoryLabel.text = headerItem.name
        headerView.touchUpInsideAddButton = { [unowned self] in
            showBottomSheet(repository: headerItem)
        }
    }
    
    func repository(with id: Repository.ID) -> Repository {
        let index = repositories.indexOfRepository(with: id)
        return repositories[index]
    }
    
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = "삭제"
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.deleteTodo(with: id)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
        
//    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
//        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
//        let deleteActionTitle = "삭제"
//        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { <#UIContextualAction#>, <#UIView#>, <#@escaping (Bool) -> Void#> in
//            <#code#>
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
}
