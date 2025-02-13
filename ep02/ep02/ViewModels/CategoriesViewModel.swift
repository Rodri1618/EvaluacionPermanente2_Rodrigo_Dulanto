//
//  CategoriesViewModel.swift
//  ep02
//
//  Created by Casa on 12/02/25.
//

import Foundation
import SwiftUI


class CategoriesViewModel: ObservableObject {
    @Published var categories: [RecipeCategory] = []
   
    
    @Published var errorMessage: String? = nil
    private let categorie = CategoriesService()
    
    
    
    func fetchCategories() {
        categorie.fetchCategories { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    

    

}

