//
//  RecipeCusineGroupsList.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import ImageLoader
import SwiftUI

struct RecipeCusineGroupsList: View {
    
    let groups: [RecipeCusineGroup]
    let style: Style
    
    var body: some View {
        List {
            ForEach(groups, id: \.name) {
                RecipeCusineListSection(group: $0, style: style)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.fetchPrimaryBackground)
    }
    
    // MARK: - Enums
    
    enum Style {
        case grid
        case simple
        
        var systemImageName: String {
            return switch self {
            case .grid:
                "circle.grid.3x3.circle.fill"
            case .simple:
                "list.bullet.circle.fill"
            }
        }
    }
}

#Preview("Grid Style") {
    RecipeCusineGroupsList(
        groups: .mock,
        style: .grid
    ).environmentObject(RemoteImageDownloader.mock)
}

#Preview("Simple Style") {
    RecipeCusineGroupsList(
        groups: .mock,
        style: .simple
    ).environmentObject(RemoteImageDownloader.mock)
}
