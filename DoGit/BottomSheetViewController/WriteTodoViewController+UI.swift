//
//  WriteTodoViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/21.
//

import UIKit

extension WriteTodoViewController {
    
    func configureLayout() {
        titleLabel.font = UIFont.Font.bold18
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        contentTextField.clearButtonMode = .whileEditing
        contentTextField.borderStyle = .none
        contentTextField.tintColor = .mainColor
        view.addSubview(contentTextField)
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            contentTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        view.layoutIfNeeded()
        contentTextField.underLine(borderColor: .mainColor)
        
        doneButton.setTitle("등록", for: .normal)
        doneButton.titleLabel?.font = UIFont.Font.regular16
        doneButton.backgroundColor = .mainColor
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 5
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 20),
            doneButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
