//
//  RecipeDetailsService.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation

class RecipeDetailsService {
    func fetchRecipeDetails(recipeName: String, completion: @escaping (Result<RecipeDetail, Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipeName)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipeDetailsResponse.self, from: data)
                if let recipeDetail = decodedResponse.meals.first {
                    completion(.success(recipeDetail))
                } else {
                    completion(.failure(NSError(domain: "No recipe details found", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
