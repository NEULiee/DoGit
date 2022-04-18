//
//  AddRepositoryViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import UIKit

extension AddRepositoryViewController {
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        // MARK: navigation bar
        let barAttribute = [NSAttributedString.Key.font : UIFont.Font.regular16]
        let titleAttribute = [NSAttributedString.Key.font : UIFont.Font.bold18]
        navigationItem.title = "나의 저장소"
        navigationController?.navigationBar.titleTextAttributes = titleAttribute
        
        let cancelBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didCancelAdd(_:)))
        cancelBarButton.tintColor = .gray
        cancelBarButton.setTitleTextAttributes(barAttribute, for: .normal)
        navigationItem.leftBarButtonItem = cancelBarButton
        
        let saveBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(didSaveRepository(_:)))
        saveBarButton.setTitleTextAttributes(barAttribute, for: .normal)
        navigationItem.rightBarButtonItem = saveBarButton
        saveBarButton.tintColor = .mainColor
        
        // MARK: view
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "저장소 이름을 입력해주세요."
        searchBar.searchTextField.font = UIFont.Font.light14
        searchBar.searchBarStyle = .minimal
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    func addCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
