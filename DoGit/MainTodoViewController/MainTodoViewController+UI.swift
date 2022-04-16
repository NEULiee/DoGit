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
        addRepositoryButton.addTarget(self, action: #selector(touchUpInsideAddButton(_:)), for: .touchUpInside)
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
        
        view.addSubview(todoView)
        
        todoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            todoView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            todoView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            todoView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func addGuideMentLabelInTodoView() {
        if let _ = collectionView {
            deleteCollectionView()
        }
        
        guideMentLabel.font = UIFont.Font.light18
        guideMentLabel.textAlignment = .center
        guideMentLabel.numberOfLines = 0
        guideMentLabel.text = "오른쪽 위의 +버튼을 눌러\n저장소를 추가해주세요."
        
        todoView.addSubview(guideMentLabel)
        guideMentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guideMentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guideMentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func deleteGuidMentLabel() {
        guideMentLabel.removeFromSuperview()
    }
    
    func addCollectionViewInTodoView() {
        deleteGuidMentLabel()
        
        todoView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: todoView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: todoView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: todoView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: todoView.bottomAnchor)
        ])
    }
    
    func deleteCollectionView() {
        collectionView.removeFromSuperview()
    }
}
