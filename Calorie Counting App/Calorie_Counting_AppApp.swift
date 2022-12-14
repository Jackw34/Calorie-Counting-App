//
//  Calorie_Counting_AppApp.swift
//  Calorie Counting App
//
//  Created by Jack W on 12/5/22.
//

import SwiftUI

@main
struct Calorie_Counting_AppApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
