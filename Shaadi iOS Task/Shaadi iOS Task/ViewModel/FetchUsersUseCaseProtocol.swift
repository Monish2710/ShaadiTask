//
//  FetchUsersUseCaseProtocol.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import Foundation

// MARK: FetchUsersUseCaseProtocol

protocol FetchUsersUseCaseProtocol {
    func execute(completion: @escaping (Result<[UserDomainModel], Error>) -> Void)
}

// MARK: FetchUsersUseCase

class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let userService: UserServiceProtocol
    private let coreDataManager = PersistenceController.shared

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }

    func execute(completion: @escaping (Result<[UserDomainModel], Error>) -> Void) {
        // First, try to fetch from Core Data
        if let usersFromCoreData = coreDataManager.fetchUsers(), !usersFromCoreData.isEmpty {
            // If data is found in Core Data, map to domain models and return
            let domainModels = usersFromCoreData.map { entity in
                UserDomainModel(
                    name: entity.title ?? "",
                    profilePictureURL: entity.imageUrl ?? "",
                    location: entity.address ?? "",
                    isAccepted: entity.isAccepted,
                    isDeclined: entity.isDeclined,
                    email: entity.email ?? ""
                )
            }
            completion(.success(domainModels))
        } else {
            // If no data is found in Core Data, fetch from API
            userService.fetchUsers { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(users):
                    // Convert users to domain models
                    let domainModels = users.map { user in
                        UserDomainModel(
                            name: "\(user.name.first) \(user.name.last)",
                            profilePictureURL: user.picture.large,
                            location: "\(user.location.city), \(user.location.state), \(user.location.country)",
                            isAccepted: false,
                            isDeclined: false,
                            email: user.email
                        )
                    }
                    // Save fetched data to Core Data
                    self.coreDataManager.save(users: domainModels)
                    completion(.success(domainModels))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
