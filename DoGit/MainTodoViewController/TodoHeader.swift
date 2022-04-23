//
//  TodoHeader.swift
//  DoGit
//
//  Created by neuli on 2022/04/14.
//

import UIKit

class TodoHeader: UICollectionReusableView {
    
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    let repositoryLabel = UILabel()
    let addButton = UIButton(type: .contactAdd)
    
    var touchUpInsideAddButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
}

extension TodoHeader {
    
    private func configureUI() {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
        
        stackView.layoutIfNeeded()
        stackView.underLine(borderColor: .gray)
        
        repositoryLabel.font = UIFont.Font.bold16
        
        stackView.addArrangedSubview(repositoryLabel)
        
        addButton.tintColor = .mainColor
        // addButton.setTitleColor(.mainColor, for: .normal)
        // addButton.setTitle("할일 추가하기", for: .normal)
        // addButton.titleLabel?.font = UIFont.Font.light12
        
        addButton.addAction(UIAction(handler: { [unowned self] _ in
            self.touchUpInsideAddButton?()
        }), for: .touchUpInside)
        
        stackView.addArrangedSubview(addButton)
    }
}
