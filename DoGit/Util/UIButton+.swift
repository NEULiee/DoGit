//
//  UIButton+SetImage.swift
//  DoGit
//
//  Created by neuli on 2022/04/11.
//

import UIKit

extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFit
        setImage(UIImage(systemName: systemName), for: .normal)
    }
    
    func doGitButton(systemName: String) -> UIButton {
        let button = UIButton()
        button.setImage(systemName: systemName)
        button.tintColor = UIColor.fontColor
        return button
    }
}
