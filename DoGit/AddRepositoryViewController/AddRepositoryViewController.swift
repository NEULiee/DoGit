//
//  AddRepositoryViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit
import RealmSwift

class AddRepositoryViewController: UIViewController {
    
    let realm = try! Realm()
    
    let searchBar = UISearchBar(frame: .zero)
    
    var collectionView: UICollectionView!
    var dataSource: DataSource!
    
    let githubDataManager = GithubDataManager()
    
    var githubRepositories: [GithubRepository] = []
    var checkedRepositories: [GithubRepository] = []
    var checkedRepositoriesId: [Int64] = []
    
    override func viewDidLoad() {
        setDelegate()
        getCheckedRepositoryID()
        getRepositories()
        configureUI()
    }
}

extension AddRepositoryViewController {
    
    func setDelegate() {
        searchBar.delegate = self
    }
    
    func getCheckedRepositoryID() {
        checkedRepositoriesId = TodoRepositoryStore.shared.readTodoAllId()
    }
    
    func getRepositories() {
        githubDataManager.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                self.githubRepositories = repositories
                self.checkedRepositories = self.githubRepositories.filter { self.checkedRepositoriesId.contains($0.id) }
                DispatchQueue.main.sync {
                    self.configureCollectionView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCollectionView() {
        // 1. collection view configuration
        let listLayout = listLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
        // UI
        addCollectionView()
        
        // 2, cell registration
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistartionHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        // 3. update snapshot
        updateSnapshot(with: githubRepositories)
        
        // 4. dataSource 적용
        collectionView.dataSource = dataSource
    }
    
    func performQuery(with filter: String?) {
        let filteredGithubRepositories = filteredGithubRepositories(with: filter).sorted { $0.name.lowercased() < $1.name.lowercased() }
        updateSnapshot(with: filteredGithubRepositories)
    }
    
    func filteredGithubRepositories(with filter: String? = nil) -> [GithubRepository] {
        return githubRepositories.filter { $0.contains(filter) }
    }
    
    func createRepository(with repository: GithubRepository) {
        let repository: Repository = Repository(id: repository.id, name: repository.name)
        try! realm.write {
            realm.add(repository)
        }
    }
}

// MARK: - UISearchBarDelegate
extension AddRepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        performQuery(with: searchText)
    }
}
