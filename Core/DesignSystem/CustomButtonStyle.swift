//
//  CustomButtonStyle.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public struct CustomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let type: ButtonType
    private let font: Font
    private let height: CGFloat
    private let horizontalPadding: CGFloat
    private let maxWidth: CGFloat?
    
    init(
        type: ButtonType,
        font: Font,
        height: CGFloat,
        horizontalPadding: CGFloat,
        maxWidth: CGFloat? = nil
    ) {
        self.type = type
        self.font = font
        self.height = height
        self.horizontalPadding = horizontalPadding
        self.maxWidth = maxWidth
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        
        let typeAttributes = type.attributes()
         
        let backgroundColor = if isEnabled {
            configuration.isPressed ? typeAttributes.pressedBackgroundColor : typeAttributes.backgroundColor
        } else {
            typeAttributes.disabledBackgroundColor
        }
        
        let foregroundStyle = if isEnabled {
            configuration.isPressed ? typeAttributes.pressedTextColor : typeAttributes.textColor
        } else {
            typeAttributes.disabledTextColor
        }
        
        configuration.label
            .font(font)
            .foregroundStyle(foregroundStyle)
            .multilineTextAlignment(.center)
            .padding(.horizontal, horizontalPadding)
            .frame(height: height)
            .frame(maxWidth: maxWidth)
            .background(isEnabled ? backgroundColor : nil)
            .background(isEnabled ? nil : backgroundColor.blur(radius: 80))
            .clipShape(RoundedRectangle(cornerRadius: height / 2))
    }
}

