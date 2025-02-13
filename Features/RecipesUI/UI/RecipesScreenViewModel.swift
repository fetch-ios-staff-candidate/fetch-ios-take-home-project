//
//  RecipesScreenViewModel.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Combine
import SwiftUI

class RecipesScreenViewModel: ObservableObject {
    
    @Published private(set) var state: State = .loading
    @Published var searchQuery: String = ""
    @Published var selectedCusineType: CusineType = .all
    @Published private(set) var unfilteredGroups: [RecipeCusineGroup] = []

    // MARK: - Variables
    
    private let recipesUseCases: RecipesUseCasesInterface
    private let cusineGrouper: RecipeCusineGrouper
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(
        recipesUseCases: RecipesUseCasesInterface,
        cusineGrouper: RecipeCusineGrouper
    ) {
        self.recipesUseCases = recipesUseCases
        self.cusineGrouper = cusineGrouper
        
        Publishers.CombineLatest4(
            $state.removeDuplicates(),
            $selectedCusineType.removeDuplicates(),
            $searchQuery.removeDuplicates(),
            filteredGroups.removeDuplicates()
        )
        .debounce(for: 0.1, scheduler: DispatchQueue.main)
        .map { state, selectedCusineType, searchQuery, groups in
            
            guard state != .loading, state != .error else { return state }
            
            let groups = groups.filter { selectedCusineType == .all || $0.name == selectedCusineType.title }
    
            return if groups.isEmpty {
                if searchQuery.isEmpty {
                    State.noResults
                } else {
                    State.noResultsFromSearch
                }
            } else {
                State.recipes(groups)
            }
    
        }
        .sink { [weak self] state in withAnimation { self?.state = state } }
        .store(in: &cancellables)
        
        fetchRecipes()
    }
    
    // MARK: - Public Interface
    
    func onRefreshRequested() {
        fetchRecipes()
    }
    
    // MARK: - Private Interface
    
    private lazy var filteredGroups: some Publisher<[RecipeCusineGroup], Never> = {
        Publishers.CombineLatest($searchQuery, $unfilteredGroups).map { searchQuery, groups in
            groups.map { group in
                var group = group
                
                if !searchQuery.isEmpty {
                    group.recipes = group.recipes.filter {
                        $0.name.contains(searchQuery)
                    }
                }
                
                return group
            }.filter { !$0.recipes.isEmpty }
        }
    }()
    
    private func fetchRecipes() {
        
        if state == .error {
            state = .loading
        }
        
        Task { @MainActor in
            do {
                let recipes = try await recipesUseCases.fetchAll()
                
                withAnimation { self.state = .finishedLoading }
                
                if recipes.isEmpty {
                    withAnimation { self.unfilteredGroups = [] }
                } else {
                    let cusineGroups = cusineGrouper.group(recipes: recipes)
                    withAnimation { self.unfilteredGroups = cusineGroups }
                }
                
            } catch {
                unfilteredGroups = []
                withAnimation { self.state = .error }
            }

        }
    }
    
    // MARK - Enums
    
    enum State: Hashable {
        case loading
        case finishedLoading
        case recipes([RecipeCusineGroup])
        case error
        case noResults
        case noResultsFromSearch
        
        var groups: [RecipeCusineGroup] {
            switch self {
            case .recipes(let groups):
                return groups
            default:
                return []
            }
        }
    }
    
    enum CusineType: Hashable {
        case all
        case specific(String)
        
        var title: String {
            return switch self {
            case .all:
                "All"
            case .specific(let name):
                name
            }
        }
    }

}
