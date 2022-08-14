//
//  FavoritesViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.08.2022.
//

import Foundation

protocol FavoritesViewModelType {
    var recipeCount: Int { get set }
    func exportAllRecipes()
    func favoritesCellViewModel(forIdexPath indexPath: IndexPath) -> FavoritesCellViewModelType?
    //func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
}

class FavoritesViewModel: FavoritesViewModelType {
    
    let coreData = CoreDataInteraction()
    var recipeCount = 0
    private var recipes: [Recipe] = [] {
        willSet(recipes) {
            recipeCount = recipes.count
        }
    }
    
    init() {
        exportAllRecipes()
    }
    
    func exportAllRecipes() {
        recipes = coreData.exportFavoriteRecipe()
    }
    
    func favoritesCellViewModel(forIdexPath indexPath: IndexPath) -> FavoritesCellViewModelType? {
        let recipe = recipes[indexPath.row]
        let viewModel = FavoritesCellViewModel(name: recipe.nameRecipe, image: recipe.imageRecipe)
        return viewModel
    }
    
}
