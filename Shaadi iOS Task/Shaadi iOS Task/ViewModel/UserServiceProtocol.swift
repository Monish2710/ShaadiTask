//
//  UserServiceProtocol.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import Foundation

// MARK: UserServiceProtocol

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

// MARK: UserService

class UserService: UserServiceProtocol {
    private let baseURL = "https://randomuser.me/api"

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?results=10") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(userResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
