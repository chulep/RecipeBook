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
    
    init(recipe: RecipeModel) {
        self.name = recipe.name
        self.image = recipe.image
    }
    
}
