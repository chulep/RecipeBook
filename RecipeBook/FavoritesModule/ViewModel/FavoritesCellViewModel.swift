//
//  FavoritesCellViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.08.2022.
//

import Foundation

protocol FavoritesCellViewModelType {
    var name: String? { get }
    var image: Data? { get }
    init(name: String?, image: Data?)
}

class FavoritesCellViewModel: FavoritesCellViewModelType {
    
    var name: String?
    var image: Data?
    
    required init(name: String?, image: Data?) {
        self.name = name
        self.image = image
    }
}
