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
    
    // MARK: - Snapshot
    func makeSnapshot() {
        let repositories = DoGitStore.shared.repositories
        let repositoryIDs = repositories.map { $0.id }
        
        var snapshot = Snapshot()
        snapshot.appendSections(repositoryIDs)
        
        for repository in repositories {
            snapshot.appendItems(
                Array(repository.todos.map { $0.id }),
                toSection: repository.id
            )
        }
        
        dataSource.apply(snapshot)
    }
    
    func updateSnapshot(with id: [Todo.ID]) {
        let todos = DoGitStore.shared.todos
        var snapshot = dataSource.snapshot()
        
        if id.isEmpty {
            snapshot.reconfigureItems(todos.map { $0.id })
        } else {
            snapshot.reconfigureItems(id)
        }
        
        dataSource.apply(snapshot)
    }
    
    // MARK: - UICollectionView configuration
    func listLayout() -> UICollectionViewCompositionalLayout {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfiguration.headerMode = .supplementary
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        layoutConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistrationHandler(
        cell: UICollectionViewListCell,
        indexPath: IndexPath,
        todoID: Todo.ID
    ) {
        var contentConfiguration = cell.defaultContentConfiguration()
        let todo = DoGitStore.shared.todo(with: todoID)
        contentConfiguration.text = todo.content
        contentConfiguration.textProperties.lineBreakMode = .byCharWrapping
        contentConfiguration.textProperties.font = .regular14
        if todo.isDone {
            contentConfiguration.attributedText = strikeThrough(
                string: contentConfiguration.text ?? ""
            )
            contentConfiguration.textProperties.color = .systemGray4
        } else {
            contentConfiguration.textProperties.color = .fontColor
        }
        cell.contentConfiguration = contentConfiguration
        let background: UIView = {
            let view = UIView()
            view.backgroundColor = .backgroundColor
            return view
        }()
        cell.backgroundView = background
        cell.selectedBackgroundView = background
        
        let doneButtonConfiguration = doneButtonConfiguration(for: todo)
        cell.accessories = [.customView(configuration: doneButtonConfiguration)]
    }
    
    private func doneButtonConfiguration(
        for todo: Todo
    ) -> UICellAccessory.CustomViewConfiguration {
        let tintColor = todo.isDone ? UIColor.mainColor : UIColor.systemGray4
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "square.fill", withConfiguration: symbolConfiguration)
        
        let button = TodoDoneButton()
        button.addTarget(self, action: #selector(touchUpInsideDoneButton(_:)), for: .touchUpInside)
        button.todo = todo
        button.tintColor = tintColor
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button,
            placement: .leading(displayed: .always)
        )
    }
    
    func headerRegistartionHandler(
        headerView: TodoHeader,
        elementKind: String,
        indexPath: IndexPath
    ) {
        let headerItemID = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let headerItem = DoGitStore.shared.repository(with: headerItemID)
        headerView.backgroundColor = .backgroundColor
        headerView.repositoryLabel.text = headerItem.name
        headerView.touchUpInsideAddButton = { [unowned self] in
            presentBottomSheet(repository: headerItem)
        }
    }
}
