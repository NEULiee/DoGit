//
//  AddRepositoryViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

extension AddRepositoryViewController {
    
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        // MARK: navigation bar
        let barAttribute = [NSAttributedString.Key.font : UIFont.Font.regular16]
        let titleAttribute = [NSAttributedString.Key.font : UIFont.Font.bold18]
        navigationItem.title = "나의 저장소"
        navigationController?.navigationBar.titleTextAttributes = titleAttribute
        
        let cancelBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didCancelAdd(_:)))
        cancelBarButton.tintColor = .mainColor
        cancelBarButton.setTitleTextAttributes(barAttribute, for: .normal)
        navigationItem.leftBarButtonItem = cancelBarButton
        
        // MARK: view
        view.addSubview(searchBar)
        searchBar.anchor(top: view.layoutMarginsGuide.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         paddingLeading: 8,
                         paddingTrailing: -8)
    }
    
    func addCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor,
                              bottom: view.layoutMarginsGuide.bottomAnchor)
    }
}
