//
//  BookViewControllerExtencion.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

extension BookViewController {
    
    @objc func openSearchBar() {
        switch searchIsOpen {
        case true:
            widthSearchView.constant = buttonSize
        case false:
            widthSearchView.constant = view.bounds.width - 40
        }
        searchIsOpen = !searchIsOpen
        searchView.openClose(condition: searchIsOpen)
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { end in
            self.searchView.textField.text = ""
        }
    }
    
    @objc func openAddRecipe() {
        switch addRecipeIsOpen {
        case true:
            widthAddRecipeView.constant = buttonSize
            heightAddRecipeView.constant = buttonSize
        case false:
            widthAddRecipeView.constant = view.bounds.width - 40
            heightAddRecipeView.constant = view.bounds.width / 3
        }
        addRecipeIsOpen = !addRecipeIsOpen
        addRecipeView.openClose(condition: addRecipeIsOpen)
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
