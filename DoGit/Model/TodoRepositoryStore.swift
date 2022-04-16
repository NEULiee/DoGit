//
//  TodoRepositoryStore.swift
//  DoGit
//
//  Created by neuli on 2022/04/15.
//

import Foundation
import RealmSwift

class TodoRepositoryStore {
    
    static let shared = TodoRepositoryStore()
    let realm = try! Realm()
    
    func readTodoAll() -> [Repository] {
        let repositories = Array(realm.objects(Repository.self))
        return repositories
    }
    
    func readTodoAllId() -> [Int64] {
        let repositories = Array(realm.objects(Repository.self))
        return repositories.map { $0.id }
    }
    
    func isExistTodoRepository(id: Int64) -> Bool {
        let repositoryArray = self.readTodoAll().filter { $0.id == id }
        if let _ = repositoryArray.first {
            return true
        }
        return false
    }
}
