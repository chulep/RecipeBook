//
//  BookViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation

protocol BookViewModelType {
    var recipes: [RecipeModel] { get }
    func bookCellViewModel(forIndexPath indexPath: IndexPath) -> BookCellViewModelType?
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType?
}

class BookViewModel: BookViewModelType {
    
    var recipes: [RecipeModel] = [RecipeModel(name: "Kура", incomingInternet: false, description: nil, exLink: nil, image: nil), RecipeModel(name: "картоха", incomingInternet: false, description: nil, exLink: nil, image: nil), RecipeModel(name: "пиHог", incomingInternet: false, description: nil, exLink: nil, image: nil), RecipeModel(name: "котлетыыыыы ыыыыыыыыыыыыыыыыыыы", incomingInternet: false, description: "nilnilnilnilnilnilnilnilnilnilnilnilnil nilnilnilnilnil nilnil nilnilnilnil nilnilnilnil nilnilnil nilnil nilnilnil nilnilnil \n nil nilnilnil nilnil", exLink: nil, image: nil), RecipeModel(name: "internet", incomingInternet: true, description: nil, exLink: URL(string: "https://1000.menu/cooking/26339-bystryi-sladkii-pirog"), image: nil)]
    
    func bookCellViewModel(forIndexPath indexPath: IndexPath) -> BookCellViewModelType? {
        return BookCellViewModel(recipe: recipes[indexPath.row])
    }
    
    func detailRecipeViewModel(forIdexPath indexPath: IndexPath) -> DetailRecipeViewModelType? {
        return DetailRecipeViewModel(recipe: recipes[indexPath.row])
    }
}
