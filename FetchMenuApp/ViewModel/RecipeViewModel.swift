//
//  RecipeViewModel.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//

import Foundation
import SwiftUI

/// A ViewModel responsible for managing the state of recipe data and interacting with the RecipeService.
@MainActor
class RecipeViewModel: ObservableObject {
    // MARK: - Published Properties
    /// The list of fetched recipes.
    @Published var recipes: [Recipe] = []
    /// An optional error message displayed when fetching fails.
    @Published var errorMessage: String?
    /// Indicates if data is currently being loaded.
    @Published var isLoading: Bool = false
    /// indicates if the data response is empty
    @Published var isEmpty: Bool = false
    
    // MARK: - Private Properties
    private let service: RecipeService
    
    // MARK: - Initializer
    /// Initializes the ViewModel with a RecipeService.
    /// - Parameter service: An implementation of the RecipeService protocol.
    init(service: RecipeService) {
        self.service = service
    }
    
    // MARK: - Public Methods
    /// Fetches recipes from the service and updates the state accordingly.
    func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        isEmpty = false
        
        do {
            if let fetchedRecipes = try await service.receipeTypes() {
                if fetchedRecipes.isEmpty {
                    // Handle empty state
                    isEmpty = true
                } else {
                    recipes = fetchedRecipes
                }
            } else {
                // Treat as empty if the response is nil
                isEmpty = true
            }
        } catch let error as RecipeFetcherError {
            // Handle malformed data or other errors
            errorMessage = mapError(error)
            recipes = [] // Ensure the recipes list is cleared
        } catch {
            // Handle unexpected errors
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
            recipes = []
        }
        
        isLoading = false
    }
    
    
    // MARK: - Private Helpers
    /// Maps `RecipeFetcherError` to user-friendly error messages.
    /// - Parameter error: The error to map.
    /// - Returns: A string representation of the error.
    private func mapError(_ error: RecipeFetcherError) -> String {
        switch error {
        case .invalidURL:
            return "The recipe URL is invalid."
        case .invalidDecode:
            return "Failed to decode recipe data."
        case .invalidResponse(let response):
            return "Invalid response: \(response.debugDescription)"
        }
    }
}
