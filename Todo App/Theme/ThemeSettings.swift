//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeSetttings: Int = UserDefaults.standard.integer(forKey: keyTheme) {
        didSet {
            UserDefaults.standard.set(self.themeSetttings, forKey: keyTheme)
        }
    }
    
}

