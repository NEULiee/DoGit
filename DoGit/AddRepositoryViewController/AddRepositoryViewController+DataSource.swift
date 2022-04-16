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
        contentConfiguration.textProperties.font = UIFont.Font.bold16
        contentConfiguration.secondaryTextProperties.font = UIFont.Font.light12
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var checkImageConfiguration = checkButtonConfiguration(for: itemIdentifier)
        checkImageConfiguration.tintColor = .mainColor
        cell.accessories = [.customView(configuration: checkImageConfiguration)]
    }
    
    private func checkButtonConfiguration(for githubRepository: GithubRepository) -> UICellAccessory.CustomViewConfiguration {
        let checkedRepositoriesId = checkedRepositories.map { $0.id }
        let symbolName = checkedRepositoriesId.contains(githubRepository.id) ? "checkmark" : ""
        let image = UIImage(systemName: symbolName)
        
        let button = RepositoryCheckButton()
        button.addTarget(self, action: #selector(didSelectRepository(_:)), for: .touchUpInside)
        button.repository = githubRepository
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
