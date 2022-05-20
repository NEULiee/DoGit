//
//  AddRepositoryViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit
import RealmSwift

class AddRepositoryViewController: UIViewController {
    
    // MARK: - Properties
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "저장소 이름을 입력해주세요."
        searchBar.searchTextField.font = UIFont.Font.light14
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    var collectionView: UICollectionView!
    var dataSource: DataSource!
    
    let githubDataManager = GithubDataManager()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setDelegate()
        setGithubRepositoriesAndConfigureCollectionView()
        configureUI()
    }
}

extension AddRepositoryViewController {
    
    // MARK: - Methods
    func setDelegate() {
        searchBar.delegate = self
    }
    
    func setGithubRepositoriesAndConfigureCollectionView() {
        
        githubDataManager.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                GithubRepositoryStore.shared.githubRepositories = repositories
                DispatchQueue.main.sync {
                    GithubRepositoryStore.shared.setCheckedRepositoriesID()
                }
                for index in 0..<repositories.count
                where GithubRepositoryStore.shared.checkedRepositoriesID.contains(repositories[index].id) {
                    GithubRepositoryStore.shared.githubRepositoryIsCheckToggle(index: index)
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
        
        collectionView.delegate = self
    }
    
    func performQuery(with filter: String?) {
        
        let filteredGithubRepositories = filteredGithubRepositories(with: filter).sorted { $0.name.lowercased() < $1.name.lowercased() }
        makeSnapshot(filteredGithubRepositories)
    }
    
    func filteredGithubRepositories(with filter: String? = nil) -> [GithubRepository] {
        return GithubRepositoryStore.shared.githubRepositories.filter { $0.contains(filter) }
    }
    
    // MARK: Alert
    
    func showToastMessageLabel() {
        
        let toastMessageLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75,
                                                      y: view.frame.size.height - 100,
                                                      width: 160,
                                                      height: 35))
        toastMessageLabel.backgroundColor = UIColor.mainColor.withAlphaComponent(1.0)
        toastMessageLabel.textAlignment = .center
        toastMessageLabel.layer.cornerRadius = 10
        toastMessageLabel.clipsToBounds = true
        toastMessageLabel.text = "저장소가 추가되었습니다."
        toastMessageLabel.textColor = .white
        toastMessageLabel.font = UIFont.Font.regular14
        view.addSubview(toastMessageLabel)
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut) {
            toastMessageLabel.alpha = 0.0
        } completion: { _ in
            toastMessageLabel.removeFromSuperview()
        }

    }
    
    func showRepositoryTodoDeleteCheckAlert(_ index: Int, _ repository: GithubRepository) {
        
        let message = "저장소 체크 해제시 등록했던 할일이 모두 사라집니다."
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = .mainColor
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 구독될듯
            DoGitStore.shared.deleteRepository(with: index)
            GithubRepositoryStore.shared.githubRepositoryIsCheckToggle(index: index)
            GithubRepositoryStore.shared.setCheckedRepositoriesID()
            self.updateSnapshot(with: [repository])
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension AddRepositoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension AddRepositoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}

// MARK: - extension UIViewController : hide keyboard
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
