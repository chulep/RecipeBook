//
//  BookCellViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 17.07.2022.
//

import Foundation

protocol BookCellViewModelType: AnyObject {
    var name: String? { get }
    var image: Data? { get }
    var fromURL: Bool { get }
    init(recipe: Recipe)
}

class BookCellViewModel: BookCellViewModelType {
    var image: Data?
    var name: String?
    var fromURL = false
    
    required init(recipe: Recipe) {
        self.image = recipe.imageRecipe
        self.name = recipe.nameRecipe
        if recipe.exURL != "" && recipe.exURL != nil { fromURL = true }
    }
    
}
