//
//  RecipeDetail.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation


struct RecipeDetail: Codable, Identifiable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let imageUrl: String
    let ingredients: [String: String]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case imageUrl = "strMealThumb"
       
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)

        var ingredients: [String: String] = [:]
        for index in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(index)")!
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty, !measure.isEmpty {
                ingredients[ingredient] = measure
            }
        }
        self.ingredients = ingredients
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(area, forKey: .area)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(imageUrl, forKey: .imageUrl)

        for index in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(index)")!
            if let ingredient = ingredients.keys.sorted().indices.contains(index - 1) ? ingredients[ingredients.keys.sorted()[index - 1]] : nil,
               let measure = ingredients.values.sorted().indices.contains(index - 1) ? ingredients[ingredients.keys.sorted()[index - 1]] : nil {
                try container.encode(ingredient, forKey: ingredientKey)
                try container.encode(measure, forKey: measureKey)
            }
        }
    }
}

struct RecipeDetailsResponse: Codable {
    let meals: [RecipeDetail]
}

