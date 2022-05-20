//
//  MainTodoViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/09.
//

import UIKit

extension MainTodoViewController {
    
    func configureUI() {

        view.backgroundColor = .backgroundColor
        
        addRepositoryButton.addTarget(self, action: #selector(touchUpInsideAddButton(_:)), for: .touchUpInside)
        addRepositoryButton.setDimensions(height: 28, width: 28)

        menuButton.addTarget(self, action: #selector(touchUpInsideSettingButton(_:)), for: .touchUpInside)
        menuButton.setDimensions(height: 28, width: 28)
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, addRepositoryButton, menuButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 12
            view.addSubview(stackView)
            return stackView
        }()
        stackView.anchor(top: view.layoutMarginsGuide.topAnchor,
                         leading: view.layoutMarginsGuide.leadingAnchor,
                         trailing: view.layoutMarginsGuide.trailingAnchor,
                         paddingTop: 20,
                         height: 40)
        
        view.addSubview(todoView)
        todoView.anchor(top: stackView.bottomAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        paddingTop: 20)
    }
    
    func addGuideMentLabelInTodoView() {
        
        if collectionView != nil {
            removeCollectionViewFromSuperView()
        }

        todoView.addSubview(guideMentLabel)
        guideMentLabel.translatesAutoresizingMaskIntoConstraints = false
        guideMentLabel.centerX(inview: view)
        guideMentLabel.centerY(inview: view)
    }
    
    func deleteGuidMentLabel() {
        guideMentLabel.removeFromSuperview()
    }
    
    func addCollectionViewInTodoView() {
        
        deleteGuidMentLabel()
        
        todoView.addSubview(collectionView)
        collectionView.anchor(top: todoView.topAnchor,
                              leading: todoView.leadingAnchor,
                              trailing: todoView.trailingAnchor,
                              bottom: todoView.bottomAnchor)
    }
    
    func removeCollectionViewFromSuperView() {
        collectionView.removeFromSuperview()
    }
}
