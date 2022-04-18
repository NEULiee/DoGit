//
//  AddRepositoryViewController+DataSource.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

extension AddRepositoryViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, GithubRepository>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, GithubRepository>
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(githubRepositories)
        
        print(#function)
        
        dataSource.apply(snapshot)
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        let layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistartionHandler(cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: GithubRepository) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = itemIdentifier.name
        contentConfiguration.secondaryText = itemIdentifier.description
        contentConfiguration.textProperties.font = UIFont.Font.bold18
        contentConfiguration.secondaryTextProperties.font = UIFont.Font.regular8
        cell.contentConfiguration = contentConfiguration
        
        let checkImageConfiguration = checkButtonConfiguration(for: itemIdentifier)
        cell.accessories = [.customView(configuration: checkImageConfiguration)]
    }
    
    private func checkButtonConfiguration(for githubRepository: GithubRepository) -> UICellAccessory.CustomViewConfiguration {
        let checkedRepositoriesId = checkedRepositories.map { $0.id }
        let tintColor = checkedRepositoriesId.contains(githubRepository.id) ? UIColor.mainColor : UIColor.systemGray4
        let image = UIImage(systemName: "checkmark")
        
        let button = RepositoryCheckButton()
        button.addTarget(self, action: #selector(didSelectRepository(_:)), for: .touchUpInside)
        button.repository = githubRepository
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
