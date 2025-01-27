//
//  Persistence.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import CoreData
import SwiftUI

class PersistenceController {
    static let shared = PersistenceController()
    private init() {}

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Shaadi_iOS_Task")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    func save(users: [UserDomainModel]) {
        let context = self.context
        for user in users {
            let entity = UserDataEntity(context: context)

            entity.title = user.name
            entity.address = user.location
            entity.imageUrl = user.profilePictureURL
            entity.isAccepted = user.isAccepted
            entity.isDeclined = user.isDeclined
        }
        do {
            try context.save()
        } catch {
            print("Failed to save users to Core Data: \(error)")
        }
    }

    func updateUserAcceptanceStatus(email: String, isAccepted: Bool, isDeclined: Bool) {
        let fetchRequest: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imageUrl == %@", email)

        do {
            if let user = try context.fetch(fetchRequest).first {
                user.isAccepted = isAccepted
                user.isDeclined = isDeclined
                try context.save()
            }
        } catch {
            print("Failed to update user status: \(error)")
        }
    }

    func fetchUsers() -> [UserDataEntity]? {
        let fetchRequest: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Failed to fetch users from Core Data: \(error)")
            return nil
        }
    }
}
