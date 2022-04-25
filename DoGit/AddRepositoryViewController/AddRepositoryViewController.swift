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
    var checkedRepositoriesId: [Int64] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        getCheckRepositories()
        getRepositories()
        configureUI()
    }
}

extension AddRepositoryViewController {
    
    func setDelegate() {
        searchBar.delegate = self
    }
    
    func getCheckRepositories() {
        checkedRepositoriesId = TodoRepositoryStore.shared.readTodoAllId()
    }
    
    func getRepositories() {
        githubDataManager.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                self.githubRepositories = repositories
                for index in 0..<self.githubRepositories.count
                where self.checkedRepositoriesId.contains(self.githubRepositories[index].id) {
                    self.githubRepositories[index].isCheck.toggle()
                }
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
        makeSnapshot()
        
        // 4. dataSource 적용
        collectionView.dataSource = dataSource
    }
    
    func performQuery(with filter: String?) {
        let filteredGithubRepositories = filteredGithubRepositories(with: filter).sorted { $0.name.lowercased() < $1.name.lowercased() }
        makeSnapshot(filteredGithubRepositories)
    }
    
    func filteredGithubRepositories(with filter: String? = nil) -> [GithubRepository] {
        return githubRepositories.filter { $0.contains(filter) }
    }
    
    // MARK: - Alert
    func showRepositoryTodoDeleteCheckAlert(_ index: Int, _ repository: GithubRepository) {
        let message = "저장소 체크 해제시 등록했던 할일이 모두 사라집니다."
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = .mainColor
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.deleteRepository(with: index)
            self.githubRepositories[index].isCheck.toggle()
            self.getCheckRepositories()
            self.updateSnapshot(with: [repository])
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension AddRepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        performQuery(with: searchText)
    }
}
