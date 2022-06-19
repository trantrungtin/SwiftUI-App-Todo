//
//  ContentView.swift
//  Todo App
//
//  Created by Tin Tran on 18/06/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>

    @State private var showingAddTodoView = false
    
    // MARK: - FUNCTIONS
    private func delete(offsets: IndexSet) {
        withAnimation {
            deleteTodos(context: viewContext, todos: offsets.map{ todos[$0] })
        }
    }

    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "")
                            Spacer()
                            Text(todo.priority ?? "")
                        }
                    }
                    .onDelete(perform: delete)
                }
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView().environment(\.managedObjectContext, viewContext)
                    }
                )
                
                if todos.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
