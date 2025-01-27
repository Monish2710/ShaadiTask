//
//  Shaadi_iOS_TaskApp.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import SwiftUI

@main
struct Shaadi_iOS_TaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            UserListView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
