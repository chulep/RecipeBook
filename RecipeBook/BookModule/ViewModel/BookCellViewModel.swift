//
//  BookCellViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 17.07.2022.
//

import Foundation
import UIKit

protocol BookCellViewModelType: AnyObject {
    var name: String { get }
    var image: UIImage? { get }
}

class BookCellViewModel: BookCellViewModelType {
        
    var name: String
    var image: UIImage?
    
    init(recipe: Recipe) {
        name = recipe.nameRecipe ?? ""
        
        switch recipe { // запихать в расширение уи имадж
        case _ where recipe.exURL == nil && recipe.imageRecipe == nil:
            image = UIImage(systemName: "pencil.circle")
        case _ where recipe.exURL != nil && recipe.imageRecipe == nil:
            image = UIImage(systemName: "globe")
        default:
            image = UIImage(data: recipe.imageRecipe!)
        }
    }
    
}
