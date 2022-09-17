//
//  AddRecipeUICreator.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 17.09.2022.
//

import UIKit

protocol AddRecipeUICreatorType {
    func createImageButton(bounds: CGRect) -> UIButton
    func createNameTextField() -> UITextField
    func createUrlTextField() -> UITextField
    func createDescriptionTextView() -> UITextView
}

class AddRecipeUICreator: AddRecipeUICreatorType {
    
    func createImageButton(bounds: CGRect) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: bounds.width / 6)), for: .normal)
        button.addTarget(nil, action: #selector(AddRecipeViewController.touchSetImage), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }
    
    func createNameTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.placeholder = "Введите название"
        return textField
    }
    
    func createUrlTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.placeholder = "Вставьте ссылку"
        return textField
    }
    
    func createDescriptionTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.text = "Опишите рецепт"
        textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 15)
        return textView
    }
    
}
