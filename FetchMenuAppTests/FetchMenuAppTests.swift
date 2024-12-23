//
//  FetchMenuAppTests.swift
//  FetchMenuAppTests
//
//  Created by ousmane diouf on 12/22/24.
//

import XCTest
@testable import FetchMenuApp

@MainActor
final class RecipeViewModelTests: XCTestCase {
    func testLoadRecipesWithValidData() async {
        // Arrange
        let mockService = MockRecipeService(responseType: .valid)
        let viewModel = RecipeViewModel(service: mockService)
        
        // Act
        await viewModel.loadRecipes()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes.first?.recipeName, "Spaghetti Carbonara")
    }

    func testLoadRecipesWithMalformedData() async {
        // Arrange
        let mockService = MockRecipeService(responseType: .malformed)
        let viewModel = RecipeViewModel(service: mockService)
        
        // Act
        await viewModel.loadRecipes()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to decode recipe data.")
        XCTAssertFalse(viewModel.isEmpty) // Malformed is not treated as empty
    }

    func testLoadRecipesWithEmptyData() async {
        // Arrange
        let mockService = MockRecipeService(responseType: .empty)
        let viewModel = RecipeViewModel(service: mockService)
        
        // Act
        await viewModel.loadRecipes()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.recipes.isEmpty)
    }

    func testLoadRecipesWithInvalidURL() async {
        // Arrange
        let mockService = MockRecipeService(responseType: .invalidURL)
        let viewModel = RecipeViewModel(service: mockService)
        
        // Act
        await viewModel.loadRecipes()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "The recipe URL is invalid.")
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testLoadRecipesWithUnexpectedError() async {
        // Arrange
        let mockService = MockRecipeService(responseType: .unexpectedError)
        let viewModel = RecipeViewModel(service: mockService)
        
        // Act
        await viewModel.loadRecipes()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "An unexpected error occurred: The operation couldn’t be completed. (Test error 1.)")
    }
}
