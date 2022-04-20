//
//  WriteTodoViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/19.
//

import UIKit

class WriteTodoViewController: UIViewController {
    
    let titleLabel = UILabel()
    let contentTextView = UITextView()
    let doneButton = UIButton()
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureLayout()
    }
}

extension WriteTodoViewController {
    
    private func configureLayout() {
//        titleLabel.text = "할일 추가하기"
//        titleLabel.font = UIFont.Font.bold16
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
//        ])
//        
//        contentTextView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            contentTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            contentTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            contentTextView.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        doneButton.setTitle("등록", for: .normal)
//        doneButton.tintColor = .mainColor
//        doneButton.layer.cornerRadius = 10
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            doneButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 12),
//            doneButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            doneButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            doneButton.heightAnchor.constraint(equalToConstant: 20)
//        ])
    }
}
