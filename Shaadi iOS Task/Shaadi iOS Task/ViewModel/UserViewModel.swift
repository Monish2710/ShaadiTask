//
//  UserViewModel.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import Foundation

// MARK: FetchUsersUseCase

class UserViewModel: ObservableObject {
    @Published var users: [UserDomainModel] = []
    @Published var errorMessage: String?

    private let fetchUsersUseCase: FetchUsersUseCaseProtocol

    init(fetchUsersUseCase: FetchUsersUseCaseProtocol = FetchUsersUseCase()) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    func loadUsers() {
        fetchUsersUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(users):
                    self?.users = users
                case let .failure(error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func acceptUser(user: UserDomainModel) {
        PersistenceController.shared.updateUserAcceptanceStatus(
            email: user.profilePictureURL,
            isAccepted: true,
            isDeclined: false
        )
        loadUsers() // Reload users to refresh the UI
    }

    func declineUser(user: UserDomainModel) {
        PersistenceController.shared.updateUserAcceptanceStatus(
            email: user.profilePictureURL,
            isAccepted: false,
            isDeclined: true
        )
        loadUsers() // Reload users to refresh the UI
    }
}
