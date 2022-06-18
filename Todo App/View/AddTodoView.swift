//
//  AddTodoView.swift
//  Todo App
//
//  Created by Tin Tran on 18/06/2022.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var priority: Priority = .Normal
    
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
        } //: NAVIGATION
    }
}

// MARK: - PREVEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
