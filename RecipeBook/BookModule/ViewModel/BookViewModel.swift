//
//  BookViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation
import UIKit

protocol BookViewModelType {
    var recipeCount: Int? { get set }
    func searchRecipe(text: String)
    func bookCellViewModel(forIdexPath indexPath: IndexPath) -> BookCellViewModelType?
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
}

class BookViewModel: BookViewModelType {
    
    var recipeCount: Int?
    var recipeModel: RecipeCoreData = RecipeCoreData()
    private var parentArrayRecipies: [Recipe]?
    private var recipes: [Recipe]? {
        willSet (recipes) {
            recipeCount = recipes?.count
        }
    }
    
    init() {
        exportAllRecipes()
    }
    
    private func exportAllRecipes() {
        parentArrayRecipies = recipeModel.exportAllRecipe()
        recipes = parentArrayRecipies
    }
    
    func bookCellViewModel(forIdexPath indexPath: IndexPath) -> BookCellViewModelType? {
        guard let recipes = recipes else { return nil }
        return BookCellViewModel(recipe: recipes[indexPath.row])
    }
    
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType? {
        guard let recipes = recipes else { return nil }
        return DetailRecipeViewModel(recipe: recipes[indexPath.row])
    }
    
    func searchRecipe(text: String) {
        if text == "" {
            recipes = parentArrayRecipies
        } else {
            recipes = parentArrayRecipies?.filter({ return String($0.nameRecipe ?? "").lowercased().contains(text.lowercased()) })
        }
    }
    
}
