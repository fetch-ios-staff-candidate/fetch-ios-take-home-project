//
//  MediumButtonStyles.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public extension ButtonStyle where Self == CustomButtonStyle {
    
    static var mediumPrimary: CustomButtonStyle {
        create(
            type: .primary,
            maxWidth: nil
        )
    }
    
    static func mediumPrimary(
        maxWidth: CGFloat? = nil
    ) -> CustomButtonStyle {
        create(
            type: .primary,
            maxWidth: maxWidth
        )
    }
    
    private static func create(
        type: ButtonType,
        maxWidth: CGFloat? = nil
    ) -> CustomButtonStyle {
        .init(
            type: type,
            font: .weGoBold(17),
            height: 48,
            horizontalPadding: 12,
            maxWidth: maxWidth
        )
    }
    
}
