//
//  TodoRepositoryStore.swift
//  DoGit
//
//  Created by neuli on 2022/04/15.
//

import Foundation
import RealmSwift

final class DoGitStore {
    
    static let shared = DoGitStore()
    let realm = try! Realm()
    var repositories: [Repository] = []
    var todos: [Todo] = []
    var user: String = ""
    
    private init() { }
    
    func readAll() {
        DoGitStore.shared.readRepositoryAll()
        DoGitStore.shared.readTodoAll()
        DoGitStore.shared.readCurrentUser()
    }
    
    func resetDoGitStore() {
        try! realm.write {
            for repository in DoGitStore.shared.repositories {
                realm.delete(repository)
            }
            for todo in DoGitStore.shared.todos {
                realm.delete(todo)
            }
        }
    }
    
    // MARK: - Repository
    func readRepositoryAll() {
        DoGitStore.shared.repositories = Array(realm.objects(Repository.self).sorted(byKeyPath: "name"))
    }
    
    func readRepositoryIDAll() -> [Int64] {
        return DoGitStore.shared.repositories.map { $0.id }
    }
    
    func isExistRepository(id: Int64) -> Bool {
        guard let _ = DoGitStore.shared.repositories.filter({ $0.id == id }).first
        else { return false }
        return true
    }
    
    func repository(with repositoryID: Repository.ID) -> Repository {
        let index = repositories.indexOfRepository(with: repositoryID)
        return repositories[index]
    }
    
    func createRepository(with repository: GithubRepository) {
        let todo: Todo = Todo(content: "왼쪽으로 스와이프 시 삭제할 수 있습니다.")
        let repository: Repository = Repository(id: repository.id, name: repository.name)
        try! realm.write {
            realm.add(repository)
            repository.todos.append(todo)
        }
        DoGitStore.shared.readAll()
    }
    
    func deleteRepository(with index: Int) {
        if let savedRepository = realm.objects(Repository.self).filter({
            $0.id == GithubRepositoryStore.shared.githubRepositories[index].id }).first {
            try! realm.write {
                realm.delete(savedRepository.todos)
                realm.delete(savedRepository)
            }
        }
        DoGitStore.shared.readAll()
    }
    
    // MARK: - Todo
    func readTodoAll() {
        DoGitStore.shared.todos = Array(realm.objects(Todo.self))
    }
    
    func readTodoIDAll() -> [String] {
        return DoGitStore.shared.todos.map { $0.id }
    }
    
    func todo(with todoID: Todo.ID) -> Todo {
        let index = todos.indexOfTodo(with: todoID)
        return todos[index]
    }
    
    func todoIsDoneToggle(with todoID: Todo.ID) {
        let todo = todo(with: todoID)
        try! realm.write {
            todo.isDone.toggle()
        }
    }
    
    func appendTodoInRepository(repository: Repository, todo: Todo) {
        try! realm.write {
            repository.todos.append(todo)
        }
    }
    
    func updateTodo(todo: Todo, content: String) {
        try! realm.write {
            todo.content = content
        }
    }
    
    func deleteTodo(with todoID: Todo.ID) {
        guard let todo = realm.objects(Todo.self).filter({ $0.id == todoID }).first
        else { return }
        
        try! realm.write {
            realm.delete(todo)
        }
    }
    
    // MARK: - User
    func readCurrentUser() {
        guard let user = realm.objects(User.self).last?.name else { return }
        DoGitStore.shared.user = user
    }
}
