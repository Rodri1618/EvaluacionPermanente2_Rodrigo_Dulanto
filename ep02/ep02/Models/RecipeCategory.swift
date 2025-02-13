
// Ep02 Rodrigo Dulanto
//
//  Created by Casa on 13/02/25.
//

import Foundation


struct RecipeCategory: Codable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageUrl = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}


struct CategoriesResponse: Codable {
    let categories: [RecipeCategory]
}

