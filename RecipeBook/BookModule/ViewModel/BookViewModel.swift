//
//  BookViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation

protocol BookViewModelType {
    var recipeCount: Int? { get set }
    func exportAllRecipes()
    func searchRecipe(text: String)
    func bookCellViewModel(forIdexPath indexPath: IndexPath) -> BookCellViewModelType?
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
}

class BookViewModel: BookViewModelType {
    
    var recipeCount: Int?
    var recipeModel: CoreDataInteraction = CoreDataInteraction()
    private var parentArrayRecipies: [Recipe]?
    private var recipes: [Recipe]? {
        willSet (recipes) {
            recipeCount = recipes?.count
        }
    }
    
    init() {
        exportAllRecipes()
    }
    
    func exportAllRecipes() {
        parentArrayRecipies = recipeModel.exportAllRecipe()
        recipes = parentArrayRecipies
    }
    
    func bookCellViewModel(forIdexPath indexPath: IndexPath) -> BookCellViewModelType? {
        guard let recipes = recipes else { return nil }
        return BookCellViewModel(recipe: recipes[indexPath.row])
    }
    
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType? {
        guard let recipes = recipes else { return nil }
        return DetailRecipeViewModel(recipe: recipes[indexPath.row], indexPath: indexPath)
    }
    
    func searchRecipe(text: String) {
        if text == "" {
            recipes = parentArrayRecipies
        } else {
            recipes = parentArrayRecipies?.filter({ return String($0.nameRecipe ?? "").lowercased().contains(text.lowercased()) })
        }
    }
    
}
