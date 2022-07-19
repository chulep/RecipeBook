//
//  DetailRecipeViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 19.07.2022.
//

import Foundation
import UIKit

protocol DetailRecipeViewModelType {
    var image: UIImage? { get }
    var name: String { get }
    var description: String? { get }
    init(recipe: RecipeModel)
}

class DetailRecipeViewModel: DetailRecipeViewModelType {
    var image: UIImage?
    var name: String
    var description: String?

    required init(recipe: RecipeModel) {
        self.image = recipe.image
        self.name = recipe.name
        self.description = recipe.description
    }
}
