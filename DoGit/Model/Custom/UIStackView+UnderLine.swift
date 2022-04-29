//
//  UIStackView+UnderLine.swift
//  DoGit
//
//  Created by neuli on 2022/04/23.
//

import UIKit

extension UIStackView {
    
    func underLine(borderColor: UIColor) {
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height + 24, width: self.frame.width - 20, height: 1)
        border.borderWidth = 1
        border.borderColor = borderColor.cgColor
        self.layer.addSublayer(border)
    }
}
