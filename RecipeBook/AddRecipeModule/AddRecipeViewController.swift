//
//  AddIndependViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.07.2022.
//

import UIKit

class AddRecipeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var image = UIImage()
    private var imageButton = UIButton()
    private var nameTextField = UITextField()
    private var descriptionTextView = UITextView()
    private var urlTextField = UITextField()
    private var imagePickerController: UIImagePickerController!
    weak var delegate: reloadRecipeDelegate?
    
    var viewModel: AddRecipeViewModelType!
    var UICreator: AddRecipeUICreatorType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        createNavBarStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageButton.layer.cornerRadius = imageButton.bounds.height / 2
        nameTextField.layer.cornerRadius = nameTextField.bounds.height / 3
        urlTextField.layer.cornerRadius = nameTextField.bounds.height / 3
        descriptionTextView.layer.cornerRadius = descriptionTextView.bounds.height / 30
    }
    
    //MARK: - Init
    enum Action {
        case url
        case inddepend
    }
    
    convenience init(action: Action, viewModel: AddRecipeViewModelType, UICreator: AddRecipeUICreatorType) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.UICreator = UICreator
        
        switch action {
        case .url:
            descriptionTextView.isHidden = true
            descriptionTextView.text = nil
        case .inddepend:
            urlTextField.isHidden = true
            urlTextField.text = nil
        }
    }
    
    //MARK: - UI
    func createUI() {
        for i in [imageButton, nameTextField, urlTextField, descriptionTextView] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        //imageButton = UICreator.createImageButton(bounds: view.bounds)
        imageButton.setImage(UIImage(systemName: "camera")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: view.bounds.width / 6)), for: .normal)
        imageButton.addTarget(nil, action: #selector(AddRecipeViewController.touchSetImage), for: .touchUpInside)
        imageButton.tintColor = .white
        imageButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.clipsToBounds = true
        
        nameTextField = UICreator.createNameTextField()
        urlTextField = UICreator.createUrlTextField()
        descriptionTextView = UICreator.createDescriptionTextView()
        descriptionTextView.delegate = self
        
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
        animateAndSave()
    }
    
    //MARK: - TextView Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
            textView.text = ""
            textView.textColor = .black
            textView.textAlignment = .natural
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Опишите рецепт"
            textView.textColor = UIColorHelper.systemLightGray
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
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        image = info[.originalImage] as! UIImage
        image.jpegData(compressionQuality: 0.4)
        imageButton.setImage(image, for: .normal)
    }
    
    private func animateAndSave() {
        
        for i in [nameTextField, urlTextField] {
            if i.text == "" {
                i.center.x += 5
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: []) {
                    i.center.x -= 5
                }
            }
        }
        
        
        if descriptionTextView.text == "" || descriptionTextView.text == "Опишите рецепт" {
            descriptionTextView.center.x += 5
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: []) {
                self.descriptionTextView.center.x -= 5
            }
        }
        
        if urlTextField.isHidden {
            if nameTextField.text != "" && descriptionTextView.text != "Опишите рецепт" && descriptionTextView.text != "" {
                let imageData = UIImage.jpegData(image)(compressionQuality: 0.5)
                viewModel.saveRecipe(name: nameTextField.text, description: descriptionTextView.text, image: imageData, exURL: nil)
                dismiss(animated: true)
                delegate?.updateListRecipe()
            }
        }
        
        if descriptionTextView.isHidden {
            if nameTextField.text != "" && urlTextField.text != "" {
                let imageData = UIImage.jpegData(image)(compressionQuality: 0.5)
                viewModel.saveRecipe(name: nameTextField.text, description: nil, image: imageData, exURL: urlTextField.text)
                dismiss(animated: true)
                delegate?.updateListRecipe()
            }
        }
    }
    
}
