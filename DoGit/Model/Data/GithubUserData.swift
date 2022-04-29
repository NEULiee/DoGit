//
//  UserData.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import Foundation

struct GithubUserData: Codable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
