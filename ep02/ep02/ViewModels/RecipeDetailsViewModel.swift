//
//  RecipeDetailsViewModel.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation
import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    
    @Published var recipeDetail: RecipeDetail?
    @Published var errorMessage: String? = nil
    private let recipeDetailsService = RecipeDetailsService()
    
    func fetchRecipeDetails(for recipeName: String) {
        recipeDetailsService.fetchRecipeDetails(recipeName: recipeName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeDetail):
                    self.recipeDetail = recipeDetail
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
