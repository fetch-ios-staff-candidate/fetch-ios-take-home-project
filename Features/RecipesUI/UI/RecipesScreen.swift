//
//  RecipesScreen.swift
//  recipes-fetch
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DesignSystem
import ImageLoader
import SwiftUI
import SwiftData

public struct RecipesScreen: View {
    
    @StateObject private var viewModel: RecipesScreenViewModel
    @State private var listStyle: RecipeCusineGroupsList.Style = .grid
    
    init(viewModel: RecipesScreenViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                SearchBar(
                    searchText: $viewModel.searchQuery,
                    backgroundColor: .fetchPrimaryBackground
                )
                
                ListStyleButton(type: .grid)
                ListStyleButton(type: .simple)
                
            }
            .padding(.horizontal, 16)
            
            if !viewModel.unfilteredGroups.isEmpty {
                CusineTypePicker(
                    groups: viewModel.unfilteredGroups,
                    selectedCusineType: $viewModel.selectedCusineType
                ).frame(height: 50)
                
            }
            
            ZStack {
                RecipeCusineGroupsList(groups: viewModel.state.groups, style: listStyle)
                
                Group {
                    switch viewModel.state {
                    case .loading:
                        VStack {
                            Text("Loading Recipes...", bundle: .recipesUI)
                            
                            ProgressView()
                                .controlSize(.regular)
                                .progressViewStyle(.circular)
                                .tint(.fetchLightPurple)
                        }
                    case .noResults:
                        Text("No recipes exist.", bundle: .recipesUI)
                    case .noResultsFromSearch:
                        Text("No recipes found matching your search.", bundle: .recipesUI)
                    case .error:
                        VStack {
                            Text("An error occurred while fetching recipes.", bundle: .recipesUI)
                            
                            Button(action: {
                                viewModel.onRefreshRequested()
                            }, label: {
                                Text("Try Again", bundle: .recipesUI)
                            })
                            .buttonStyle(CustomButtonStyle.mediumPrimary)
                        }
                    case .recipes, .finishedLoading:
                        EmptyView()
                    }
                }
                .textStyle(.secondaryTitle)
                .multilineTextAlignment(.center)
                .padding(.top, -64)
            }
           
        }
        .background(.fetchPrimaryBackground)
        .refreshable { viewModel.onRefreshRequested() }
  
    }

   
    @ViewBuilder
    private func ListStyleButton(type: RecipeCusineGroupsList.Style) -> some View {
        
        let isSelected = (type == listStyle)
        
        Button(action: {
            withAnimation { listStyle = type }
        }, label: {
            Image(systemName: type.systemImageName)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(isSelected ? .fetchLightPurple : .fetchPrimaryBackground)
                .background(Circle().fill(isSelected ? .fetchPrimaryBackground : .fetchLightPurple))
        })
    }
    
}

private func BuildPreview(
    recipesUseCases: RecipesUseCasesInterface, 
    searchQuery: String = ""
) -> some View {
    let viewModel = RecipesScreenViewModel(
        recipesUseCases: recipesUseCases,
        cusineGrouper: .mock
    )
    viewModel.searchQuery = searchQuery
    
    return RecipesScreen(
        viewModel: viewModel
    ).environmentObject(RemoteImageDownloader.mock)
}

#Preview("Recipes State") {
    BuildPreview(
        recipesUseCases: .mock(secondsDelay: 0, items: .mock)
    )
}

#Preview("Loading State") {
    BuildPreview(
        recipesUseCases: .mock(secondsDelay: 10000, items: .mock)
    )
}

#Preview("No Results State") {
    BuildPreview(
        recipesUseCases: .mock(secondsDelay: 0, items: [])
    )
}

#Preview("No Results From Search State") {
    BuildPreview(
        recipesUseCases: .mock(secondsDelay: 0, items: []),
        searchQuery: "Fetch Rewards"
    )
}

#Preview("Error State") {
    BuildPreview(
        recipesUseCases: .mock(secondsDelay: 0, items: [], throwError: true),
        searchQuery: "Fetch Rewards"
    )
}
