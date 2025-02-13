//
//  recipes_fetchApp.swift
//  recipes-fetch
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import RecipesUI
import SwiftUI
import SwiftData

@main
struct recipes_fetchApp: App {
    
    private let appComponent = AppComponent()

    var body: some Scene {
        WindowGroup {
            appComponent.recipesScreen()
        }
        .environmentObject(appComponent.remoteImageDownloader)
    }
}
