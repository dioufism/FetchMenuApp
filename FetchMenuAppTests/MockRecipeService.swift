//
//  MockRecipeService.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/23/24.
//

import XCTest
@testable import FetchMenuApp

/// A mock implementation of RecipeService for testing.
class MockRecipeService: RecipeService {
    enum ResponseType {
        case valid
        case malformed
        case empty
        case invalidURL
        case unexpectedError
    }
    
    var responseType: ResponseType
    
    init(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func receipeTypes() async throws -> [Recipe]? {
        switch responseType {
        case .valid:
            return [
                Recipe(
                    cuisine: "Italian",
                    recipeName: "Spaghetti Carbonara",
                    recipeId: "1",
                    largePhoto: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    smallPhoto: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    recipeSource: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    youtubeUrl: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                )
            ]
        case .malformed:
            throw RecipeFetcherError.invalidDecode
        case .empty:
            return []
        case .invalidURL:
            throw RecipeFetcherError.invalidURL
        case .unexpectedError:
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
    }
}
