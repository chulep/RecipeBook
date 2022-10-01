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
    private var action: Action!
    
    var viewModel: AddRecipeViewModelType!
    var UICreator: AddRecipeUICreatorType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavBarStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UICreator.settingsRadius(imageButton: imageButton, nameTextField: nameTextField, descriptionTextView: descriptionTextView, urlTextField: urlTextField)
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
        self.action = action
    }
    
    //MARK: - UI
    func createUI() {
        view.backgroundColor = .white
        imageButton = UICreator.createImageButton(bounds: view.bounds)
        nameTextField = UICreator.createNameTextField()
        descriptionTextView = UICreator.createDescriptionTextView(action: action)
        descriptionTextView.delegate = self
        urlTextField = UICreator.createUrlTextField(action: action)
        
        for i in [imageButton, nameTextField, urlTextField, descriptionTextView] {
            view.addSubview(i)
        }
        
        UICreator.createConstraints(view: view, imageButton: imageButton, nameTextField: nameTextField, descriptionTextView: descriptionTextView, urlTextField: urlTextField)
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
        UICreator.shakeAnimationIsFilling(nameTextField, urlTextField, descriptionTextView) { textIsFilling in
            if textIsFilling {
                let imageData = UIImage.jpegData(self.image)(compressionQuality: 0.4)
                self.viewModel.saveRecipe(name: self.nameTextField.text,
                                          description: self.descriptionTextView.text,
                                          image: imageData,
                                          exURL: self.urlTextField.text)
                self.dismiss(animated: true)
                self.delegate?.updateListRecipe()
            }
        }
    }
    
    //MARK: - TextView Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
            textView.text = ""
            textView.textColor = ColorHelper.systemBlack
            textView.textAlignment = .natural
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Опишите рецепт"
            textView.textColor = ColorHelper.systemLightGray
            textView.textAlignment = .center
        }
    }
    
    //MARK: - UIPickerController
    @objc func touchSetImage() {
        imagePickerController = UICreator.imagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        image = info[.originalImage] as! UIImage
        image.jpegData(compressionQuality: 0.4)
        imageButton.setImage(image, for: .normal)
    }
    
}
