//
//  GithubRepository.swift
//  DoGit
//
//  Created by neuli on 2022/04/22.
//

import Foundation

struct GithubRepository: Hashable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    var isCheck: Bool = false
    
    init(_ id: Int64, _ name: String, _ description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    mutating func setCheck() {
        self.isCheck.toggle()
    }
    
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

extension Array where Element == GithubRepository {
    func indexOfGithubRepository(with id: GithubRepository.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { fatalError() }
        return index
    }
}
