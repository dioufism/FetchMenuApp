//
//  Recipe.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]?
}

struct Recipe: Codable, Hashable { // this response is optional
    let cuisine: String
    let recipeName: String
    let recipeId: String
    let largePhoto: String?
    let smallPhoto: String?
    let recipeSource: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey  {
        case cuisine
        case recipeName = "name"
        case recipeId =  "uuid"
        case largePhoto = "photo_url_large"
        case smallPhoto = "photo_url_small"
        case recipeSource = "source_url"
        case youtubeUrl = "youtube_url"
    }
}
