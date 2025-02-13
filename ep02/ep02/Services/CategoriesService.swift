//
//  CategoriesService.swift
//  ep02
//
//  Created by Casa on 13/02/25.
//

import Foundation

class CategoriesService{
    func fetchCategories(completion: @escaping (Result<[RecipeCategory], Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else { return }

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
                let decodedResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                completion(.success(decodedResponse.categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
