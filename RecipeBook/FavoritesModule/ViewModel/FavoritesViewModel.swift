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
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
    init(coreData: CoreDataInteractionType)
}

class FavoritesViewModel: FavoritesViewModelType {
    
    let coreData: CoreDataInteractionType
    var recipeCount = 0
    private var recipes: [Recipe] = [] {
        willSet(recipes) {
            recipeCount = recipes.count
        }
    }
    
    required init(coreData: CoreDataInteractionType) {
        self.coreData = coreData
    }
    
    //MARK: - Methods
    func exportAllRecipes() {
        recipes = coreData.exportRecipe(request: .favoriteRecipe)
    }
    
    func favoritesCellViewModel(forIdexPath indexPath: IndexPath) -> FavoritesCellViewModelType? {
        let recipe = recipes[indexPath.row]
        let viewModel = FavoritesCellViewModel(recipe: recipe)
        return viewModel
    }
    
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType? {
        let recipe = recipes[indexPath.row]
        return DetailRecipeViewModel(recipe: recipe, indexPath: indexPath, forModule: .favoriteModule)
    }
}
