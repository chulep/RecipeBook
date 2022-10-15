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
    var constrantDescriptionView = NSLayoutConstraint()
    var constraintsConfirmButton = NSLayoutConstraint()
    var keyboeardIsOpen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavBarStyle()
        constrantDescriptionView = descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        constraintsConfirmButton = confirmButton.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UICreator.settingsRadius(imageButton: imageButton, nameTextField: nameTextField, descriptionTextView: descriptionTextView, urlTextField: urlTextField)
        
        confirmButton.addTarget(self, action: #selector(viewEndEditing), for: .touchUpInside)
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewEndEditing))
        view.addGestureRecognizer(tap)
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
        UICreator.addKeyboardNotification(observer: self, selectorShow: #selector(keyboardWillShow(notification:)), selectorHide: #selector(keyboardWillHide(notification:)))
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
        UICreator.deleteKeyboardNotification(observer: self)
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
    @objc func keyboardWillShow(notification: Notification) {
        if keyboeardIsOpen == false {
            var userInfo = notification.userInfo!
            let keyboardFrame = userInfo.removeValue(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            myKeyboradFrame = keyboardFrame.cgRectValue
            view.frame.origin.y -= myKeyboradFrame!.height
            constrantDescriptionView.constant = (myKeyboradFrame!.height + 5)
            constrantDescriptionView.isActive = true
            confirmButton.isHidden = false
            constraintsConfirmButton.constant = view.bounds.width / 10
            constraintsConfirmButton.isActive = true
            view.layoutIfNeeded()
            keyboeardIsOpen = !keyboeardIsOpen
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y += myKeyboradFrame?.height ?? 0
        view.removeConstraint(constrantDescriptionView)
        constraintsConfirmButton.constant = 0
        constraintsConfirmButton.isActive = true
        confirmButton.isHidden = true
        view.layoutIfNeeded()
        keyboeardIsOpen = !keyboeardIsOpen
    }
    
    @objc func viewEndEditing() {
        view.endEditing(true)
    }
    
}
