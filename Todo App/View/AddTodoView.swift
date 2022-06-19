//
//  AddTodoView.swift
//  Todo App
//
//  Created by Tin Tran on 18/06/2022.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var priority: Priority = .Normal
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    private func save() {
        if self.name != "" {
            saveTodo(context: self.viewContext, name: self.name, priority: self.priority)
            self.name = ""
        } else {
            self.errorShowing = true
            self.errorTitle = "Invalid name"
            self.errorMessage = "Make sure to enter something for\nthe new todo item."
            return
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        self.save();
                    }) {
                        Text("Save")
                    }
                }
                
                Spacer()
            } //: VSTACK
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
