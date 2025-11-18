//
//  ToDoApp.swift
//  ToDo
//
//  Created by Kyaw Thiha on 18/11/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Task.self])
    }
}
