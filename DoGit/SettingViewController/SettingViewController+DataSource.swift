//
//  SettingViewController+DataSource.swift
//  DoGit
//
//  Created by neuli on 2022/04/28.
//

import UIKit

extension SettingViewController {
    enum Section {
        case setting
        case developer
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}
