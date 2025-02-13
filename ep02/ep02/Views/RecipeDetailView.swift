//
//  RecipeDetailView.swift
//  e
//
//  Created by Casa on 13/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct RecipeDetailView: View {
    let recipeName: String
    @ObservedObject private var viewModel = RecipeDetailsViewModel()
    
    var body: some View {
        ScrollView {
            if let recipeDetail = viewModel.recipeDetail {
                VStack(alignment: .leading, spacing: 20) {
                    AsyncImage(url: URL(string: recipeDetail.imageUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: 350, maxHeight: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(recipeDetail.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text("Category: \(recipeDetail.category)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("Area: \(recipeDetail.area)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text(recipeDetail.instructions)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(5)
                        .padding(.horizontal)
                    
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ForEach(Array(recipeDetail.ingredients.keys.sorted()), id: \.self) { key in
                        HStack {
                            Text(key)
                                .font(.body)
                            Spacer()
                            Text(recipeDetail.ingredients[key]!)
                                .font(.body)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal) 
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchRecipeDetails(for: recipeName)
                    }
            }
        }
        .navigationTitle(recipeName)
    }
}
