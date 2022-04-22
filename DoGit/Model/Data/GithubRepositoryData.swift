//
//  GithubRepositoryList.swift
//  DoGit
//
//  Created by neuli on 2022/04/16.
//

import Foundation

struct GithubRepositoryData: Codable {
    let id: Int64
    let name: String
    let description: String?
    
    init(_ id: Int64, _ name: String) {
        self.init(id, name, "")
    }
    
    init(_ id: Int64, _ name: String, _ description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
