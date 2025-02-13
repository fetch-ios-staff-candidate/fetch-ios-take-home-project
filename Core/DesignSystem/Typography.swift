//
//  Typography.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftUI

public extension Font {
    
    static func weGoRegular(_ size: CGFloat) -> Font {
        Font.custom("WeGoSans-Regular", size: size)
    }
    
    static func weGoBold(_ size: CGFloat) -> Font {
        Font.custom("WeGoSerif-Bold", size: size)
    }
    
}
