//
//  AddLinkViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 15.07.2022.
//

import UIKit

class AddLinkViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var image = UIImage()
    private var imageButton = UIButton()
    private var nameRecipe = UITextField()
    private var linkTextField = UITextField()
    private var imagePickerController: UIImagePickerController!
    private var recipeModel = RecipeCoreData()

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
        linkTextField.layer.cornerRadius = linkTextField.bounds.height / 3
    }
    
    //MARK: - UI
    func createUI() {
        for i in [imageButton, nameRecipe, linkTextField] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        imageButton.tintColor = .white
        imageButton.setImage(UIImage(systemName: "camera")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: view.bounds.width / 6)), for: .normal)
        imageButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageButton.addTarget(self, action: #selector(touchSetImage), for: .touchUpInside)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.clipsToBounds = true

        nameRecipe.backgroundColor = .white
        nameRecipe.layer.borderColor = UIColor.gray.cgColor
        nameRecipe.layer.borderWidth = 1
        nameRecipe.textAlignment = .center
        nameRecipe.placeholder = "Введите название"
        
        linkTextField.backgroundColor = .white
        linkTextField.layer.borderColor = UIColor.gray.cgColor
        linkTextField.layer.borderWidth = 1
        linkTextField.textAlignment = .center
        linkTextField.placeholder = "Вставьте ссылку"
        
        
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110),
            imageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -110),
            imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor),
            
            nameRecipe.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 15),
            nameRecipe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            nameRecipe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            nameRecipe.heightAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1/4),
            
            linkTextField.topAnchor.constraint(equalTo: nameRecipe.bottomAnchor, constant: 15),
            linkTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            linkTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            linkTextField.heightAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1/4),
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
        recipeModel.saveRecipe(name: nameRecipe.text, description: nil, image: image, exURL: linkTextField.text)
        dismiss(animated: true)
    }
    
    //MARK: - UIPickerController (camera)
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
        let newImage = info[.originalImage] as? UIImage
        newImage?.jpegData(compressionQuality: 0.4)
        imageButton.setImage(newImage, for: .normal)
    }
}
