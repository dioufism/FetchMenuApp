//
//  RecipeListView.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel(service: RecipeURLFetcher())
    @State private var searchText: String = ""
    @State private var isSorted: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                // Sort Button
                HStack {
                    Spacer()
                    Button(action: {
                        isSorted.toggle()
                    }) {
                        HStack {
                            Text(isSorted ? "Sort: Cuisine ↓" : "Sort: Cuisine ↑")
                            Image(systemName: isSorted ? "arrow.down" : "arrow.up")
                        }
                        .font(.callout)
                    }
                    .padding(.horizontal)
                }

                // Recipe List
                if viewModel.isLoading {
                    ProgressView("Fetching recipes...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task { await viewModel.loadRecipes() }
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    List(filteredRecipes, id: \.recipeId) { recipe in
                        NavigationLink(value:recipe) {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        /// To make refreshing smooth  adda a 3 second timeout
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        await viewModel.loadRecipes()
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                    .disableAutocorrection(true)
                    .navigationDestination(for: Recipe.self) { recipe in
                        RecipeDetailView(recipe: recipe)
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
    
    // Filter recipes based on search text
    private var filteredRecipes: [Recipe] {
        let sortedRecipes = isSorted
            ? viewModel.recipes.sorted { $0.cuisine.lowercased() < $1.cuisine.lowercased() }
            : viewModel.recipes
        
        if searchText.isEmpty {
            return sortedRecipes
        } else {
            return sortedRecipes.filter { recipe in
                recipe.recipeName.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

// MARK: - Recipe Card View
struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            CachedImageView(url: recipe.smallPhoto, imageWidth: 60, imageHeight: 60, showError: false)

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.recipeName)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    RecipeListView()
}
