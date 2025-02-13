//
//  Colors.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public extension Color {
    static var fetchOrange: Color { .init("light-orange", bundle: .designSystem) }
    static var fetchDarkPurple: Color { .init("dark-purple", bundle: .designSystem) }
    static var fetchLightPurple: Color { .init("light-purple", bundle: .designSystem) }
    static var fetchPrimaryBackground: Color { .init("primary-background", bundle: .designSystem) }
}

public extension ShapeStyle where Self == Color {
    static var fetchOrange: Color { .fetchOrange }
    static var fetchDarkPurple: Color { .fetchDarkPurple }
    static var fetchLightPurple: Color { .fetchLightPurple }
    static var fetchPrimaryBackground: Color { .fetchPrimaryBackground }
}
