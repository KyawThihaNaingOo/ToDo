//
//  ContentView.swift
//  ToDo
//
//  Created by Kyaw Thiha on 18/11/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Task]
    
    @State private var newTitle = ""
    @State private var selectedTask: Task?
    @State private var showAlert = false
    @State private var showingMessage = false
    
    var body: some View {
        VStack {
            List {
                ForEach(tasks) { task in
                    Text(task.title)
                        .swipeActions {
                            Button(role: .destructive) {
                                selectedTask = task
                                showAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .alert("Delete this task?", isPresented: $showAlert) {
                            Button("Delete", role: .destructive) {
                                if let t = selectedTask {
                                    context.delete(t)
                                }
                            }
                        }
                    
                }
            }
            ZStack {
                HStack {
                    TextField("Enter task", text: $newTitle)
                        .submitLabel(.done) // Changes the keyboard return key to 'Done'
                        .onSubmit {
                            // 1. Safety check (trimmed to catch strings that are just spaces)
                            guard !newTitle.trimmingCharacters(in: .whitespaces).isEmpty else {
                                showingMessage = true
                                return
                            }
                            
                            // 2. Create and Insert
                            let task = Task(title: newTitle)
                            context.insert(task)
                            
                            // 3. Clear the field
                            newTitle = ""
                        }
                    Button("Add") {
                        guard !newTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        let task = Task(title: newTitle)
                        context.insert(task)
                        newTitle = ""
                    }
                }.padding()
            }
        }.showToast(isShowing: $showingMessage, message: "Task Saved!")
        //        .padding()
    }
}


#Preview {
    ContentView()
}
