//
//  MainTodoViewController+DataSource.swift
//  DoGit
//
//  Created by neuli on 2022/04/09.
//

import UIKit

extension MainTodoViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Repository, Todo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Repository, Todo>
    
    func getRepositories() {
        repositories = TodoRepositoryStore.shared.readAll()
    }
    
    func updateSnapshot() {
        getRepositories()
        
        var snapshot = Snapshot()
        snapshot.appendSections(repositories)
        
        for repository in repositories {
            snapshot.appendItems(Array(repository.todos), toSection: repository)
        }
        
        dataSource.apply(snapshot)
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfiguration.headerMode = .supplementary
        layoutConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, todo: Todo) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = todo.content
        contentConfiguration.textProperties.font = UIFont.Font.light14
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: todo)
        doneButtonConfiguration.tintColor = .mainColor
        cell.accessories = [.customView(configuration: doneButtonConfiguration)]
    }
    
    private func doneButtonConfiguration(for todo: Todo) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = todo.isDone ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        let button = TodoDoneButton()
        button.addTarget(self, action: #selector(touchUpInsideDoneButton(_:)), for: .touchUpInside)
        button.todo = todo
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func headerRegistartionHandler(headerView: TodoHeader, elementKind: String, indexPath: IndexPath) {
        let headerItem = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        headerView.repositoryLabel.text = headerItem.name
        headerView.touchUpInsideAddButton = { [unowned self] in
            addTodo(repository: headerItem)
        }
    }
    
    private func addTodo(repository: Repository) {
        // 투두 추가하는 함수
    }
}
