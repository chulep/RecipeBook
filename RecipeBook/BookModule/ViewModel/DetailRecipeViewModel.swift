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
    var name: String { get }
    var description: String? { get }
    var incomingInternet: Bool { get }
    var exLink: URL? { get }
    init(recipe: RecipeModel)
}

class DetailRecipeViewModel: DetailRecipeViewModelType {
    var image: UIImage?
    var name: String
    var description: String?
    var incomingInternet: Bool
    var exLink: URL?

    required init(recipe: RecipeModel) {
        self.image = recipe.image
        self.name = recipe.name
        self.description = recipe.description
        self.incomingInternet = recipe.incomingInternet
        self.exLink = recipe.exLink
    }
}
