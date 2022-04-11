//
//  MainTodoViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/09.
//

import UIKit

extension MainTodoViewController {
    
    func configureUI() {

        view.backgroundColor = .white
        
        // nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.Font.bold32
        nameLabel.sizeToFit()
        
        addRepositoryButton.setImage(systemName: "plus")
        addRepositoryButton.tintColor = .darkGray
        NSLayoutConstraint.activate([
            addRepositoryButton.widthAnchor.constraint(equalToConstant: 28),
            addRepositoryButton.heightAnchor.constraint(equalToConstant: 28),
        ])

        menuButton.setImage(systemName: "ellipsis")
        menuButton.tintColor = .darkGray
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 28),
            menuButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, addRepositoryButton, menuButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 12
            view.addSubview(stackView)
            return stackView
        }()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    func addGuideMentLabel() {
        let guideMentLabel: UILabel = UILabel()
        
        guideMentLabel.font = UIFont.Font.light18
        guideMentLabel.textAlignment = .center
        guideMentLabel.numberOfLines = 0
        guideMentLabel.text = "오른쪽 위의 +버튼을 눌러\n저장소를 추가해주세요."
        
        view.addSubview(guideMentLabel)
        guideMentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guideMentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guideMentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func deleteGuidMentLabel() {
        
    }
}
