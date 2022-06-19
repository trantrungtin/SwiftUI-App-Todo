//
//  TodoModel.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import Foundation
import CoreData

func saveTodo(context: NSManagedObjectContext, name: String, priority: Priority) {
    let todo = Todo(context: context)
    todo.name = name
    todo.priority = priority.rawValue
    do {
        try context.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
