//
//  Persistence.swift
//  Todo App
//
//  Created by Tin Tran on 18/06/2022.
//

import CoreData

struct PersistenceController {
    // MARK: - PERSISTENT CONTROLLER
    static let shared = PersistenceController()

    // MARK: - PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let priorities: [Priority] = [.High, .Normal, .Low]
        for i in 0..<10 {
            let newItem = Todo(context: viewContext)
            newItem.id = UUID()
            newItem.name = "Sample Task\(i)"
            newItem.priority = priorities.randomElement() ?? .Normal
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Todo_App")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
