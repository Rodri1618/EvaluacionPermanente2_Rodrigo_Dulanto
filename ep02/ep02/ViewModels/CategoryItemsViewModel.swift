//
//  CategoryItemsViewModel.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation
import SwiftUI

class CategoryItemsViewModel: ObservableObject {
    @Published var errorMessage: String? = nil
    @Published var categoryItems: [RecipeItem] = []
    private let categoryItem = CategoryItemsService()
 
    
    func fetchCategoryItems(for category: String) {
        categoryItem.fetchCategoryItems(category: category) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.categoryItems = items
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
