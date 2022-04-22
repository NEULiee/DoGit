//
//  Todo.swift
//  DoGit
//
//  Created by neuli on 2022/04/06.
//

import Foundation
import RealmSwift

class Repository: Object, Identifiable {
    
    @Persisted var id: Int64
    @Persisted var name: String
    
    @Persisted var todos = List<Todo>()
    
    convenience init(id: Int64, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

extension Array where Element == Repository {
    func indexOfRepository(with id: Repository.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { fatalError() }
        return index
    }
}
