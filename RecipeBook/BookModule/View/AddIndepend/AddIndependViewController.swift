//
//  AddIndependViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.07.2022.
//

import UIKit

class AddIndependViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var image = UIImage()
    private var imageButton = UIButton()
    private var nameRecipe = UITextField()
    private var descriptionRecipe = UITextView()
    private var imagePickerController: UIImagePickerController!
    weak var delegate: addRecipeDelegate?
    var recipeModel = RecipeCoreData()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        createNavBarStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageButton.layer.cornerRadius = imageButton.bounds.height / 2
        nameRecipe.layer.cornerRadius = nameRecipe.bounds.height / 3
        descriptionRecipe.layer.cornerRadius = descriptionRecipe.bounds.height / 30
    }
    
    //MARK: - UI
    func createUI() {
        for i in [imageButton, nameRecipe, descriptionRecipe] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        imageButton.setImage(UIImage(systemName: "camera")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: view.bounds.width / 6)), for: .normal)
        imageButton.addTarget(self, action: #selector(touchSetImage), for: .touchUpInside)
        imageButton.tintColor = .white
        imageButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.clipsToBounds = true

        nameRecipe.backgroundColor = .white
        nameRecipe.layer.borderColor = UIColor.gray.cgColor
        nameRecipe.layer.borderWidth = 1
        nameRecipe.textAlignment = .center
        nameRecipe.placeholder = "Введите название"
        
        descriptionRecipe.backgroundColor = .white
        descriptionRecipe.layer.borderColor = UIColor.gray.cgColor
        descriptionRecipe.layer.borderWidth = 1
        descriptionRecipe.delegate = self
        descriptionRecipe.text = "Опишите рецепт"
        descriptionRecipe.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descriptionRecipe.textAlignment = .center
        descriptionRecipe.font = UIFont.boldSystemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110),
            imageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -110),
            imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor),
            
            nameRecipe.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 15),
            nameRecipe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            nameRecipe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            nameRecipe.heightAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1/4),
            
            descriptionRecipe.topAnchor.constraint(equalTo: nameRecipe.bottomAnchor, constant: 15),
            descriptionRecipe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionRecipe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionRecipe.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
    }
    
    func createNavBarStyle() {
        title = "Новый рецепт"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelItemButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(confirmItemButton))
    }
    
    //MARK: - Target method
    @objc func cancelItemButton() {
        dismiss(animated: true)
    }
    
    @objc func confirmItemButton() {
        recipeModel.saveRecipe(name: nameRecipe.text, description: descriptionRecipe.text, image: image, exURL: nil)
        delegate?.updateRecipe()
        dismiss(animated: true)
    }

    //MARK: - TextView Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
            textView.text = nil
            textView.textColor = .black
            textView.textAlignment = .natural
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Опишите рецепт"
                textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                textView.textAlignment = .center
            }
    }
    
    //MARK: - UIPickerController
    @objc func touchSetImage() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
        print("открыт")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        image = info[.originalImage] as! UIImage
        image.jpegData(compressionQuality: 0.4)
        imageButton.setImage(image, for: .normal)
    }
}
