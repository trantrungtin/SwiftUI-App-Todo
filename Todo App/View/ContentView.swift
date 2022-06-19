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
    @EnvironmentObject var iconSettings: IconNames
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData

    @State private var showingSettingsView = false
    @State private var showingAddTodoView = false
    @State private var animatingButton = false
    
    private var themeColor : Color {
        themes[theme.themeSetttings].themeColor
    }
    
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
                    leading: EditButton().accentColor(themeColor),
                    trailing:
                    Button(action: {
                        self.showingSettingsView.toggle()
                    }) {
                        Image(systemName: "paintbrush")
                            .imageScale(.large)
                    }
                    .accentColor(themeColor)
                    .sheet(isPresented: $showingSettingsView) {
                        SettingsView()
                            .environmentObject(self.iconSettings)
                    }
                )
                
                if todos.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, viewContext)
            }
            .overlay(
                ZStack {
                    Circle()
                        .fill(themeColor)
                        .opacity(self.animatingButton ? 0.2 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 68, height: 68, alignment: .center)
                    
                    Circle()
                        .fill(themeColor)
                        .opacity(self.animatingButton ? 0.15 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 88, height: 88, alignment: .center)
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(colorBase))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: BUTTON
                    
                }
                .accentColor(themeColor)
                .onAppear {
                    withAnimation(.easeOut(duration: 2).repeatForever(autoreverses: true)) {
                        self.animatingButton.toggle()
                    }
                }
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
