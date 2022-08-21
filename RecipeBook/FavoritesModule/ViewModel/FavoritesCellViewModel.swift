//
//  FavoritesCellViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.08.2022.
//

import Foundation

protocol FavoritesCellViewModelType {
    var name: String? { get }
    var image: Data? { get }
    var fromURL: Bool { get }
    init(recipe: Recipe)
}

class FavoritesCellViewModel: FavoritesCellViewModelType {
    
    var name: String?
    var image: Data?
    var fromURL = false
    
    required init(recipe: Recipe) {
        self.name = recipe.nameRecipe
        self.image = recipe.imageRecipe
        if recipe.exURL != nil { fromURL = true }
    }
}
