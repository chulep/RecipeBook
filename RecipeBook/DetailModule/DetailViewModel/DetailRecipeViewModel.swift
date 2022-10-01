//
//  DetailRecipeViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 19.07.2022.
//

import Foundation

protocol DetailRecipeViewModelType {
    var image: Data? { get }
    var name: String? { get }
    var description: String? { get }
    var exURL: String? { get }
    var favoriteRecipe: Bool { get set }
    var isOffline: Bool { get set }
    var forModule: ForModule { get }
    func tapToFavorite()
    func deleteRecipe()
    init(recipe: Recipe, indexPath: IndexPath, forModule: ForModule)
}

class DetailRecipeViewModel: DetailRecipeViewModelType {
    
    var image: Data?
    var name: String?
    var description: String?
    var exURL: String?
    var favoriteRecipe: Bool
    var isOffline: Bool
    var forModule: ForModule
    private var indexPath: IndexPath
    let model = CoreDataInteraction()

    required init(recipe: Recipe, indexPath: IndexPath, forModule: ForModule) {
        self.name = recipe.nameRecipe
        self.description = recipe.descriptionRecipe
        self.exURL = recipe.exURL
        self.favoriteRecipe = recipe.favoriteRecipe
        self.indexPath = indexPath
        self.forModule = forModule
        self.image = recipe.imageRecipe
        
        if exURL == "" || exURL == nil {
            isOffline = true
        } else {
            isOffline = false
        }
    }
    
    func tapToFavorite() {
        favoriteRecipe = !favoriteRecipe
        model.tapToFavorite(forModule: forModule, indexPath: indexPath, favorite: favoriteRecipe)
    }
    
    func deleteRecipe() {
        model.deleteRecipe(indexPath: indexPath)
    }
    
}
