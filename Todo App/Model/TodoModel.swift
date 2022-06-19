//
//  TodoModel.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import Foundation
import CoreData
import SwiftUI

extension Todo {
    var priority: Priority {
        get {
            if let priorityValue = self.priorityValue {
                return Priority(rawValue: priorityValue) ?? .Normal
            }
            return .Normal
        }
        
        set {
            self.priorityValue = newValue.rawValue
        }
    }
}

func saveTodo(context: NSManagedObjectContext, name: String, priority: Priority) {
    let todo = Todo(context: context)
    todo.name = name
    todo.priority = priority
    do {
        try context.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

func deleteTodos(context: NSManagedObjectContext, todos: [Todo]) {
    do {
        for todo in todos {
            context.delete(todo)
        }
        try context.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
