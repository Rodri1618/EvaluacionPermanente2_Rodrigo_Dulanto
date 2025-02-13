//
//  RecipeItem.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation

// Elementos de la categoría
struct RecipeItem: Codable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}


struct RecipeItemsResponse: Codable {
    let meals: [RecipeItem]
}

