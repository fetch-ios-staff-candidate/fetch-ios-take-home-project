//
//  RecipesScreenViewModelTests.swift
//  RecipesUITests
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Foundation
import Testing
@testable import RecipesUI

class RecipesScreenViewModelTests {
    
    @Test("Loading state is the inital state")
    func loadingState() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: []), cusineGrouper: .mock)
        #expect(viewModel.state == .loading)
    }
    
    @Test("Error state when the network request fails")
    func errorState() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: [], throwError: true), cusineGrouper: .mock)
        let state = await viewModel.$state.values.first { $0 != .loading && $0 != .finishedLoading }
        #expect(state == .error)
    }
    
    @Test("No results state when the network request returns an empty array")
    func noResultsState() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: []), cusineGrouper: .mock)
        let state = await viewModel.$state.values.first { $0 != .loading && $0 != .finishedLoading }
        #expect(state == .noResults)
    }
    
    @Test("No results from search state when the search term does not match any results")
    func noResultsFromSearchState() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: .mock), cusineGrouper: .mock)
        viewModel.searchQuery = UUID().uuidString
        let state = await viewModel.$state.values.first { $0 != .loading && $0 != .finishedLoading }
        #expect(state == .noResultsFromSearch)
    }
    
    @Test("Recipes state when the search query is empty and there are results")
    func recipiesStateWithEmptySearch() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: .mock), cusineGrouper: .mock)
        let state = await viewModel.$state.values.first { $0 != .loading && $0 != .finishedLoading }
        
        switch state {
        case .recipes(let groups):
            #expect(!groups.isEmpty)
        default:
            #expect(Bool(false))
        }
    }
    
    @Test("Only American recipes are shown when the selected cuisine type is American")
    func americanRecipesOnly() async {
        let viewModel = RecipesScreenViewModel(recipesUseCases: .mock(secondsDelay: 0, items: .mock), cusineGrouper: .mock)
        viewModel.selectedCusineType = .specific("American")
        
        let state = await viewModel.$state.values.first { $0 != .loading && $0 != .finishedLoading }
        
        switch state {
        case .recipes(let groups):
            #expect(groups.count == 1)
            #expect(groups.first?.name == "American")
        default:
            #expect(Bool(false))
        }
    }

}
