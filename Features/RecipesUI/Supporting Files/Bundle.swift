//
//  Bundle.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Foundation

extension Bundle {
    static var recipesUI: Bundle { .init(for: RecipesUI.self) }
    private class RecipesUI {}
}
