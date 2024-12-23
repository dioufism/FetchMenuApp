//
//  RecipeEnvironment.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//


import Foundation

public struct RecipeEnvironment: Equatable {
    let host: String
    let scheme: String = "https"
    let urlRecipesPath: String = "recipes.json"
}

extension RecipeEnvironment {
    public static let prod = RecipeEnvironment(host: "d3jbb8n5wk0qxi.cloudfront.net")
    public static let qa = RecipeEnvironment(host: "some qa link")
}

protocol RecipeEnvironmentResolving {
    var current: RecipeEnvironment { get }
}

public struct RecipeEnvironmentResolver: RecipeEnvironmentResolving {
    private var override: RecipeEnvironment?
    
    init(override: RecipeEnvironment? = nil) {
        self.override = override
    }
    var current: RecipeEnvironment {
        if let override {
            return override
        } else {
#if DEBUG
            return .qa
            #else
            return  .prod
            #endif
        }
    }
}
