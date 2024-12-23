//
//  RecipeDetailView.swift
//  FetchMenuApp
//
//  Created by ousmane diouf on 12/22/24.
//


import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedImageView(url: recipe.largePhoto, imageWidth: 300, imageHeight: 200, showError: false)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(recipe.recipeName)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                // Source Link
                if let source = recipe.recipeSource, let url = URL(string: source) {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "link.circle")
                            Text("View Source")
                                .font(.body)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                }

                // YouTube Link
                if let youtube = recipe.youtubeUrl, let youtubeURL = URL(string: youtube) {
                    Link(destination: youtubeURL) {
                        HStack {
                            Image(systemName: "play.rectangle")
                            Text("Watch on YouTube")
                                .font(.body)
                                .underline()
                        }
                        .foregroundColor(.red)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.large)
    }
}
