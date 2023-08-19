//
//  MNMLApp.swift
//  MNML
//
//  Created by Finn-Rasmus Darge on 19.08.23.
//

import SwiftUI

@main
struct MNMLApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
