//
//  Bundle.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Foundation

extension Bundle {
    static var designSystem: Bundle { .init(for: DesignSystem.self) }
    private class DesignSystem {}
}
