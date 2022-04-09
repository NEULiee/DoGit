//
//  User.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation

class User {
    
    static let shared = User()
    
    var name: String = ""
    
    private init() {}
}
