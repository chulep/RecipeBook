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
    var name: String? { get }
    var descriptionView: String? { get }
    var exURL: String? { get }
    init(recipe: Recipe)
}

class DetailRecipeViewModel: DetailRecipeViewModelType {
    var image: UIImage?
    var name: String?
    var descriptionView: String?
    var exURL: String?

    required init(recipe: Recipe) {
        self.name = recipe.nameRecipe
        self.descriptionView = recipe.descriptionRecipe
        self.exURL = recipe.exURL
        
        if recipe.imageRecipe == nil {
            self.image = UIImage(systemName: "globe")
        } else {
            self.image = UIImage(data: recipe.imageRecipe!)
        }
    }
    
}
