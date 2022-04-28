//
//  GithubDataManager.swift
//  DoGit
//
//  Created by neuli on 2022/04/15.
//

import Foundation
import RealmSwift

struct GithubDataManager {
    
    private let githubAPIURL = "https://api.github.com/users/"
    
    // MARK: - User
    
    func fetchUser(userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: githubAPIURL + userId) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(error ?? DoGitError.userNameNotFound))
                return
            }
            
            guard let data = data else {
                completion(.failure(DoGitError.userNameNotFound))
                return
            }
            
            if let name = self.userJSONDecoder(data: data) {
                let realm = try! Realm()
                let user = User(name: name)
                try! realm.write {
                    realm.add(user)
                }
                completion(.success(name))
            } else {
                completion(.failure(DoGitError.userNameNotFound))
            }
        }.resume()
    }
    
    private func userJSONDecoder(data: Data) -> String? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(GithubUserData.self, from: data)
            return decodeData.name
        } catch {
            print("유저 디코드 실패")
            return nil
        }
    }
    
    // MARK: - Repository
    
    private func getUserName() -> String {
        let realm = try! Realm()
        let result = realm.objects(User.self)
        guard let user = result.last else { return "" }
        return user.name
    }
    
    private func getGithubRepositoryURLString() -> String {
        return githubAPIURL + getUserName() + "/repos"
    }
    
    func fetchRepositories(completion: @escaping (Result<[GithubRepository], Error>) -> Void) {
        
        guard let url = URL(string: getGithubRepositoryURLString()) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(error ?? DoGitError.failedConnectServer))
                return
            }
            
            guard let data = data else {
                completion(.failure(DoGitError.repositoryNotFound))
                return
            }
            
            if let repositoryDataList = self.repositoryJSONDecoder(data: data) {
                let repositoryList = repositoryDataList.map { GithubRepository($0.id, $0.name, $0.description ?? "") }
                completion(.success(repositoryList))
            } else {
                completion(.failure(DoGitError.repositoryNotFound))
            }
        }.resume()
    }
    
    private func repositoryJSONDecoder(data: Data) -> [GithubRepositoryData]? {
        
        print(#function)
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode([GithubRepositoryData].self, from: data)
            return decodeData.map {
                if let description = $0.description {
                    return GithubRepositoryData($0.id, $0.name, description)
                } else {
                    return GithubRepositoryData($0.id, $0.name)
                }
            }
        } catch {
            print("저장소 디코드 에러: ", error)
            return nil
        }
    }
}
