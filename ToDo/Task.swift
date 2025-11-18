//
//  Task.swift
//  ToDo
//
//  Created by Kyaw Thiha on 18/11/2025.
//


import SwiftData

@Model
class Task {
    var title: String
    var isDone: Bool

    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}
