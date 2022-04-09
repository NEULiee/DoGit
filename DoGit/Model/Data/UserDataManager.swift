//
//  UserDataManager.swift
//  DoGit
//
//  Created by neuli on 2022/04/08.
//

import Foundation

struct UserDataManager {
    
    private let githubUserURL = "https://api.github.com/users/"
    
    func fetchUser(userId: String, completion: @escaping (IsFetchUserData) -> Void) {
        
        guard let url = URL(string: githubUserURL + userId) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failed)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failed)
                return
            }
            
            guard let data = data else {
                completion(.failed)
                return
            }
            
            if let name = self.userJSONDecode(data: data) {
                User.shared.name = name
                completion(.success)
            } else {
                completion(.failed)
            }
        }.resume()
    }
    
    private func userJSONDecode(data: Data) -> String? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(UserData.self, from: data)
            return decodeData.name
        } catch {
            print("decode failed")
            return nil
        }
    }
}
