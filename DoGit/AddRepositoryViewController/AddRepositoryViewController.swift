//
//  AddRepositoryViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

class AddRepositoryViewController: UIViewController {
    
    let searchBar = UISearchBar(frame: .zero)
    
    var collectionView: UICollectionView!
    var dataSource: DataSource!
    
    let githubDataManager = GithubDataManager()
    
    var githubRepositories: [GithubRepository] = []
    var checkedRepositories: [GithubRepository] = []
    var checkedRepositoriesId: [Int64] = []
    
    override func viewDidLoad() {
        getRepositories()
        configureUI()
    }
}

extension AddRepositoryViewController {
    
    func getRepositories() {
        checkedRepositoriesId = TodoRepositoryStore.shared.readTodoAllId()
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
        updateSnapshot()
        
        // 4. dataSource 적용
        collectionView.dataSource = dataSource
    }
}
