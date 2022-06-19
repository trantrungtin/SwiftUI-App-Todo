//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import SwiftUI

final public class ThemeSettings: ObservableObject {
    @Published public var themeSetttings: Int = UserDefaults.standard.integer(forKey: keyTheme) {
        didSet {
            UserDefaults.standard.set(self.themeSetttings, forKey: keyTheme)
        }
    }
    private init() {}
    public static let shared = ThemeSettings()
}

