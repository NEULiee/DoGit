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
    
    func updateSnapshot(with repositories: [GithubRepository]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(repositories.map { $0.id })
        
        print(#function)
        
        dataSource.apply(snapshot)
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        let layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
    
    func cellRegistartionHandler(cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: GithubRepository.ID) {
        let item = repository(for: itemIdentifier)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = item.name
        contentConfiguration.secondaryText = item.description
        contentConfiguration.textProperties.font = UIFont.Font.bold18
        contentConfiguration.secondaryTextProperties.font = UIFont.Font.regular10
        cell.contentConfiguration = contentConfiguration
        
        let checkImageConfiguration = checkButtonConfiguration(for: item)
        cell.accessories = [.customView(configuration: checkImageConfiguration)]
    }
    
    private func checkButtonConfiguration(for githubRepository: GithubRepository) -> UICellAccessory.CustomViewConfiguration {
        let tintColor = githubRepository.isCheck ? UIColor.mainColor : UIColor.systemGray6
        let image = UIImage(systemName: "checkmark")
        
        let button = RepositoryCheckButton()
        button.addTarget(self, action: #selector(didSelectRepository(_:)), for: .touchUpInside)
        button.repositoryID = githubRepository.id
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func repository(for id: GithubRepository.ID) -> GithubRepository {
        let index = githubRepositories.indexOfGithubRepository(with: id)
        return githubRepositories[index]
    }
    
    func createDatasource() {
        // cell registration
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistartionHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        // update snapshot
        performQuery(with: searchBar.text)
        
        // dataSource 적용
        collectionView.dataSource = dataSource
    }
}
