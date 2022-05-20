//
//  UIColor+DoGit.swift
//  DoGit
//
//  Created by neuli on 2022/04/05.
//

import UIKit

extension UIColor {
    
    static var mainColor: UIColor {
        UIColor(named: "mainColor") ?? .green
    }
    
    static var backgroundColor: UIColor {
        UIColor(named: "backgroundColor") ?? .darkGray
    }
    
    static var fontColor: UIColor {
        UIColor(named: "fontColor") ?? .darkGray
    }
}
