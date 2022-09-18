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
    func createUrlTextField(action: AddRecipeViewController.Action) -> UITextField
    func createDescriptionTextView(action: AddRecipeViewController.Action) -> UITextView
    func createConstraints(view: UIView, imageButton: UIView, nameTextField: UIView, descriptionTextView: UIView, urlTextField: UIView)
    func imagePickerController() -> UIImagePickerController
    func settingsRadius(imageButton: UIView, nameTextField: UIView, descriptionTextView: UIView, urlTextField: UIView)
    func shakeAnimationIsFilling(_ name: UITextField, _ url: UITextField, _ description: UITextView, textIsFilling: @escaping (_ textIsFilling: Bool) -> Void)
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
    
    func createUrlTextField(action: AddRecipeViewController.Action) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.placeholder = "Вставьте ссылку"
        if action == .inddepend {
            textField.isHidden = true
        }
        return textField
    }
    
    func createDescriptionTextView(action: AddRecipeViewController.Action) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.text = "Опишите рецепт"
        textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 15)
        if action == .url {
            textView.isHidden = true
        }
        return textView
    }
    
    func createConstraints(view: UIView, imageButton: UIView, nameTextField: UIView, descriptionTextView: UIView, urlTextField: UIView) {
        for i in [imageButton, nameTextField, urlTextField, descriptionTextView] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110),
            imageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -110),
            imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 15),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1/4),
            
            descriptionTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            urlTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            urlTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            urlTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            urlTextField.heightAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1/4),
        ])
    }
    
    func imagePickerController() -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        return imagePicker
    }
    
    func settingsRadius(imageButton: UIView, nameTextField: UIView, descriptionTextView: UIView, urlTextField: UIView) {
        imageButton.layer.cornerRadius = imageButton.bounds.height / 2
        nameTextField.layer.cornerRadius = nameTextField.bounds.height / 3
        urlTextField.layer.cornerRadius = nameTextField.bounds.height / 3
        descriptionTextView.layer.cornerRadius = descriptionTextView.bounds.height / 30
    }
    
    func shakeAnimationIsFilling(_ name: UITextField, _ url: UITextField, _ description: UITextView, textIsFilling: @escaping (_ textIsFilling: Bool) -> Void) {
        var isfilling = true
        
        if url.isHidden {
            if description.text == "" || description.text == "Опишите рецепт" {
                description.center.x += 5
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: []) {
                    description.center.x -= 5
                    description.layer.borderColor = UIColorHelper.systemRed.cgColor
                }
                isfilling = false
            } else {
                description.layer.borderColor = UIColorHelper.systemMediumGray.cgColor
            }
        }
        
        for i in [name, url] {
            if i.text == "" {
                i.center.x += 5
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: []) {
                    i.center.x -= 5
                    i.layer.borderColor = UIColorHelper.systemRed.cgColor
                }
            } else {
                i.layer.borderColor = UIColorHelper.systemMediumGray.cgColor
            }
        }
        
        if url.isHidden == false && url.text == "" || name.text == "" {
            isfilling = false
        }
        
        textIsFilling(isfilling)
    }
    
}
