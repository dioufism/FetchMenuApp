//
//  RecipeFetcher.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//
import Foundation

protocol RecipeService {
    func receipeTypes() async throws -> [Recipe]?
}

public enum RecipeFetcherError: Error {
    case invalidURL
    case invalidDecode
    case invalidResponse(URLResponse)
}

struct RecipeURLFetcher: RecipeService {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        return decoder
    }
    
    var urlRequest: (URL) ->  URLRequest = { url in
        URLRequest(url:url)
    }
    
    /// Fetches the data  from a request
    /// - Parameter request: The request to fetch
    /// - Returns: The data and the response
    private func fetch(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) =  try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw RecipeFetcherError.invalidResponse(response)
        }
        print(data)
        return (data, response)
    }
    
    /// Retreives a list of  recipes from the endpoint
    ///  - Returns: The list of recipes
    func receipeTypes() async throws -> [Recipe]? {
        guard let url = urlForRecipes() else {
            throw RecipeFetcherError.invalidURL
        }
        
        let request = urlRequest(url)
        
        do {
            let (data, _) = try await fetch(request: request)
            let decodedResponse =  try decoder.decode(RecipeResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            throw RecipeFetcherError.invalidDecode
        }
        
    }
    
    /// The url for the recipe list
    /// - Returns: The recipe url
    private func urlForRecipes() -> URL? {
        //By default we will assume that the environement we are developing for is prod
        let environment = RecipeEnvironmentResolver.init(override: .prod)
        var components = URLComponents()
        components.scheme = environment.current.scheme
        components.host = environment.current.host
        components.path = "/\(environment.current.urlRecipesPath)"
        return components.url
    }
}
