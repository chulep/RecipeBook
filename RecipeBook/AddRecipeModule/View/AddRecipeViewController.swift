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
    private var confirmButton = UIButton()
    private var imagePickerController: UIImagePickerController!
    weak var delegate: reloadRecipeDelegate?
    private var action: Action!
    
    var viewModel: AddRecipeViewModelType!
    var UICreator: AddRecipeUICreatorType!
    var myKeyboradFrame: CGRect?
    var constrantsD = NSLayoutConstraint()
    var constraintsC = NSLayoutConstraint()
    var keyboeardIsOpen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavBarStyle()
        constrantsD = descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        constraintsC = confirmButton.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UICreator.settingsRadius(imageButton: imageButton, nameTextField: nameTextField, descriptionTextView: descriptionTextView, urlTextField: urlTextField)
        
        confirmButton.addTarget(self, action: #selector(tapConfirmButton), for: .touchUpInside)
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
        confirmButton.setTitle("Готово", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.isHidden = true
        
        for i in [imageButton, nameTextField, urlTextField, descriptionTextView, confirmButton] {
            view.addSubview(i)
        }
        
        UICreator.createConstraints(view: view, imageButton: imageButton, nameTextField: nameTextField, descriptionTextView: descriptionTextView, urlTextField: urlTextField, confirmButton: confirmButton)
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
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        addKeyboardNotification()
        return true
    }
    
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
        deleteKeyboardNotification()
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
    
    //MARK: - keyboard show
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deleteKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if keyboeardIsOpen == false {
            var userInfo = notification.userInfo!
            let keyboardFrame = userInfo.removeValue(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            myKeyboradFrame = keyboardFrame.cgRectValue
            view.frame.origin.y -= myKeyboradFrame!.height
            constrantsD.constant = (myKeyboradFrame!.height + 5)
            constrantsD.isActive = true
            confirmButton.isHidden = false
            constraintsC.constant = view.bounds.width / 10
            constraintsC.isActive = true
            view.layoutIfNeeded()
            keyboeardIsOpen = !keyboeardIsOpen
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y += myKeyboradFrame?.height ?? 0
        view.removeConstraint(constrantsD)
        constraintsC.constant = 0
        constraintsC.isActive = true
        confirmButton.isHidden = true
        view.layoutIfNeeded()
        keyboeardIsOpen = !keyboeardIsOpen
    }
    
    @objc func tapConfirmButton() {
        view.endEditing(true)
    }
    
}
