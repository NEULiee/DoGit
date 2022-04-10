//
//  MainTodoViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/09.
//

import UIKit

import SwiftUI

//struct CanvasViewController: UIViewControllerRepresentable {
//    typealias UIViewControllerType = MainTodoViewController
//
//    func makeUIViewController(context: Context) -> MainTodoViewController {
//        return MainTodoViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: MainTodoViewController, context: Context) {
//    }
//}
//
//@available(iOS 13.0.0, *)
//struct ViewPreview: PreviewProvider {
//    static var previews: some View {
//        CanvasViewController()
//    }
//}

extension MainTodoViewController {
    
    func configureUI() {

        view.backgroundColor = .white
        
        // nameLabel.numberOfLines = 2
        nameLabel.sizeToFit()
        
        addRepositoryButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addRepositoryButton.tintColor = .darkGray
        addRepositoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addRepositoryButton.widthAnchor.constraint(equalToConstant: 28),
            addRepositoryButton.heightAnchor.constraint(equalToConstant: 28)
        ])

        menuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuButton.tintColor = .darkGray
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 28),
            menuButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, addRepositoryButton, menuButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            view.addSubview(stackView)
            return stackView
        }()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
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
}
