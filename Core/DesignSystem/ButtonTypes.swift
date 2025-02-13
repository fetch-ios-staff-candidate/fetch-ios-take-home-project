//
//  ButtonTypes.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

protocol ButtonType {
    func attributes() -> ButtonTypeAttributes
}

struct ButtonTypeAttributes {
    let backgroundColor: Color
    let pressedBackgroundColor: Color
    let disabledBackgroundColor: Color
    let textColor: Color
    let pressedTextColor: Color
    let disabledTextColor: Color
}

struct PrimaryButtonType: ButtonType {
    func attributes() -> ButtonTypeAttributes {
        .init(
            backgroundColor: .fetchOrange,
            pressedBackgroundColor: .fetchOrange.opacity(0.8),
            disabledBackgroundColor: .fetchOrange,
            textColor: .white,
            pressedTextColor: .white,
            disabledTextColor: .white
        )
    }
}

extension ButtonType where Self == PrimaryButtonType {
    static var primary: PrimaryButtonType {
        .init()
    }
}
