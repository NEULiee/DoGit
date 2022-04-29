//
//  AddRepositoryViewController+DataSource.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

extension AddRepositoryViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, GithubRepository.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, GithubRepository.ID>
    
    func makeSnapshot(_ repositories: [GithubRepository] = []) {
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        if repositories.isEmpty {
            snapshot.appendItems(GithubRepositoryStore.shared.githubRepositories.map { $0.id })
        } else {
            snapshot.appendItems(repositories.map { $0.id })
        }
        
        dataSource.apply(snapshot)
    }
    
    func updateSnapshot(with repositories: [GithubRepository]) {
        
        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems(repositories.map { $0.id })
        dataSource.apply(snapshot)
    }
    
    // MARK: UICollectionView Configuration
    func listLayout() -> UICollectionViewCompositionalLayout {
        
        let layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistartionHandler(cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: GithubRepository.ID) {
        
        let item = GithubRepositoryStore.shared.githubRepository(for: itemIdentifier)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = item.name
        contentConfiguration.secondaryText = item.description
        contentConfiguration.textProperties.font = UIFont.Font.bold18
        contentConfiguration.secondaryTextProperties.font = UIFont.Font.regular10
        cell.contentConfiguration = contentConfiguration
//        let background: UIView = {
//            let view = UIView()
//            view.backgroundColor = .clear
//            return view
//        }()
//        cell.backgroundView = background
//        let selectedBackground: UIView = {
//            let view = UIView()
//            view.backgroundColor = .clear
//            return view
//        }()
//        cell.selectedBackgroundView = selectedBackground
        
        let checkImageConfiguration = checkButtonConfiguration(for: item)
        cell.accessories = [.customView(configuration: checkImageConfiguration)]
    }
    
    private func checkButtonConfiguration(for githubRepository: GithubRepository) -> UICellAccessory.CustomViewConfiguration {
        
        let tintColor = githubRepository.isCheck ? UIColor.mainColor : UIColor.systemGray4
        let image = UIImage(systemName: "checkmark")
        
        let button = RepositoryCheckButton()
        button.addTarget(self, action: #selector(didSelectRepository(_:)), for: .touchUpInside)
        button.repositoryID = githubRepository.id
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    

}
