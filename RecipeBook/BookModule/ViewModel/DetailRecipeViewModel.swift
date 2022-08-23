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
    var favoriteRecipe: Bool { get set }
    var forModule: CoreDataInteraction.ForModule { get }
    func tapToFavorite()
    func checkURL(urlString: String) -> Bool
    func deleteRecipe()
    init(recipe: Recipe, indexPath: IndexPath, forModule: CoreDataInteraction.ForModule)
}

class DetailRecipeViewModel: DetailRecipeViewModelType {
    
    var image: UIImage?
    var name: String?
    var descriptionView: String?
    var exURL: String?
    var favoriteRecipe: Bool
    var forModule: CoreDataInteraction.ForModule
    private var indexPath: IndexPath
    let model = CoreDataInteraction()

    required init(recipe: Recipe, indexPath: IndexPath, forModule: CoreDataInteraction.ForModule) {
        self.name = recipe.nameRecipe
        self.descriptionView = recipe.descriptionRecipe
        self.exURL = recipe.exURL
        self.favoriteRecipe = recipe.favoriteRecipe
        self.indexPath = indexPath
        self.forModule = forModule
        
        switch recipe { // запихать в расширение уи имадж
        case _ where recipe.exURL == nil && recipe.imageRecipe == nil:
            image = UIImage(systemName: "pencil.circle")
        case _ where recipe.exURL != nil && recipe.imageRecipe == nil:
            image = UIImage(systemName: "globe")
        default:
            image = UIImage(data: recipe.imageRecipe!)
        }
    }
    
    func checkURL(urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func tapToFavorite() {
        favoriteRecipe = !favoriteRecipe
        model.tapToFavorite(forModule: forModule, indexPath: indexPath, favorite: favoriteRecipe)
    }
    
    func deleteRecipe() {
        model.deleteRecipe(indexPath: indexPath)
    }
    
}
