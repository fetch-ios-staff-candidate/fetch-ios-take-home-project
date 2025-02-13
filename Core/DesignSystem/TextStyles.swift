//
//  TextStyles.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public protocol TextStyle: ViewModifier {}

public extension View {
    
    func textStyle<Style: TextStyle>(_ style: Style) -> some View {
        modifier(style)
    }
}

private let largeTitleFontSize: CGFloat = 26
private let titleFontSize: CGFloat = 21
private let bodyFontSize: CGFloat = 17
private let calloutFontSize: CGFloat = 14

// MARK: - White Title

public struct WhiteTitleStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoBold(titleFontSize))
            .foregroundStyle(.white)
    }
}

public extension TextStyle where Self == WhiteTitleStyle {
    static var whiteTitle: Self { .init() }
}

// MARK: - Dark Purple Title

public struct PrimaryBodyStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoRegular(bodyFontSize))
            .foregroundStyle(.fetchDarkPurple)
    }
}

public extension TextStyle where Self == PrimaryBodyStyle {
    static var primaryBody: Self { .init() }
}

// MARK: - Large Light Purple Title

public struct SecondaryTitleStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoBold(largeTitleFontSize))
            .foregroundStyle(.fetchLightPurple)
    }
}

public extension TextStyle where Self == SecondaryTitleStyle {
    static var secondaryTitle: Self { .init() }
}

// MARK: - List Section Header

public struct ListSectionHeaderStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoBold(titleFontSize))
            .foregroundStyle(.darkPurple)
            .padding(16)
    }
}

public extension TextStyle where Self == ListSectionHeaderStyle {
    static var listSectionHeader: Self { .init() }
}

// MARK: - White Callout Bold

public struct WhiteCalloutBoldStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoBold(calloutFontSize))
            .foregroundStyle(.white)
    }
}

public extension TextStyle where Self == WhiteCalloutBoldStyle {
    static var whiteCalloutBold: Self { .init() }
}

// MARK: - Dark Purple Callout Bold

public struct PrimaryCalloutBoldStyle: TextStyle {
    
    public func body(content: Content) -> some View {
        content
            .font(.weGoBold(calloutFontSize))
            .foregroundStyle(.fetchDarkPurple)
    }
}

public extension TextStyle where Self == PrimaryCalloutBoldStyle {
    static var primaryCalloutBold: Self { .init() }
}
