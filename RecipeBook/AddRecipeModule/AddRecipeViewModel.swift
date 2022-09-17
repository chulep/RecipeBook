//
//  AddRecipeViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 17.09.2022.
//

import Foundation

protocol AddRecipeViewModelType {
    init(coreData: CoreDataInteractionType)
    func saveRecipe(name: String?, description: String?, image: Data?, exURL: String?)
}

final class AddRecipeViewModel: AddRecipeViewModelType {
    private var coreData: CoreDataInteractionType?
    
    init(coreData: CoreDataInteractionType) {
        self.coreData = coreData
    }
    
    func saveRecipe(name: String?, description: String?, image: Data?, exURL: String?) {
        coreData?.saveRecipe(name: name, description: description, image: image, exURL: exURL)
    }
    
}
