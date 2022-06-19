//
//  Settingsview.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                
                Form {
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://autograde.app")
                        FormRowLinkView(icon: "link", color: .blue, text: "Github", link: "https://github.com/trantrungtin")
                        FormRowLinkView(icon: "play.rectangle", color: .green, text: "Demo", link: "https://github.com/trantrungtin/SwiftUI-App-Todo")
                    }
                    .padding(.vertical, 3)
                    
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Tin Tran")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }
                    .padding(.vertical, 3)
                    
                    
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright © All rights reserved.\nTin Tran")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: VSTACK
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(colorBackground.edgesIgnoringSafeArea(.all))
        } //: NAVIGATION
        
    }
}

// MARK: - PREVIEW
struct Settingsview_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
