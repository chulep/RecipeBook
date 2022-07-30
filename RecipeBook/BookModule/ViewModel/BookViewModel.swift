//
//  BookViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation

protocol BookViewModelType {
    var recipeModel: RecipeModel { get }
    var allRecipes: [RecipeData] { get }
    func exportAllRecipes()
    func bookCellViewModel(forIndexPath indexPath: IndexPath) -> BookCellViewModelType?
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
}

class BookViewModel: BookViewModelType {
    
    var recipeModel: RecipeModel = RecipeModel()
    
    var allRecipes: [RecipeData] = [RecipeData]()
    
    func exportAllRecipes() {
        allRecipes = recipeModel.exportAllRecipe()
    }
    
    func bookCellViewModel(forIndexPath indexPath: IndexPath) -> BookCellViewModelType? {
        return BookCellViewModel(recipe: allRecipes[indexPath.row])
    }
    
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType? {
        let detailRecipe = recipeModel.exportDetailRecipe(indexPath: indexPath)
        return DetailRecipeViewModel(recipe: detailRecipe ?? RecipeData())

    }

}
