//
//  CusineTypePicker.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DesignSystem
import SwiftUI

struct CusineTypePicker: View {
    
    let groups: [RecipeCusineGroup]
    let selectedCusineType: Binding<RecipesScreenViewModel.CusineType>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                
                CusinePickerItem(type: .all)
                    
                ForEach(groups, id: \.name) { group in
                    CusinePickerItem(type: .specific(group.name))
                }
            }.padding(16)
        }
    }
    
    @ViewBuilder
    private func CusinePickerItem(type: RecipesScreenViewModel.CusineType) -> some View {
        
        let isSelected = selectedCusineType.wrappedValue == type
        
        Group {
            if isSelected {
                Button(type.title) {
                    withAnimation { selectedCusineType.wrappedValue = type }
                }.textStyle(.whiteCalloutBold)
            } else {
                Button(type.title) {
                    withAnimation { selectedCusineType.wrappedValue = type }
                }.textStyle(.primaryCalloutBold)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(
                    isSelected ? .fetchOrange : .clear
                )
                .stroke(isSelected ? .clear : .fetchOrange, lineWidth: 1)
        )
    }
}

#Preview {
    CusineTypePicker(
        groups: RecipeCusineGrouper.mock.group(recipes: .mock),
        selectedCusineType: .constant(.all)
    )
}
