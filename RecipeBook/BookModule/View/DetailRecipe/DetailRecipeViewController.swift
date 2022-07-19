//
//  DetailRecipeViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 19.07.2022.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    var recipeImageView = UIImageView()
    var recipeNameLabel = UILabel()
    var recipeDescriptionTextView = UITextView()
    var supportDescriptionLabel = UILabel()
    var viewModel: DetailRecipeViewModelType? {
        willSet(viewModel) {
            recipeImageView.image = viewModel?.image
            recipeNameLabel.text = viewModel?.name
            recipeDescriptionTextView.text = viewModel?.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBarStyle()
        createUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func createUI() {
        view.backgroundColor = .white
        
        for i in [recipeNameLabel, recipeDescriptionTextView, recipeImageView, supportDescriptionLabel] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        recipeImageView.tintColor = .white
        
        recipeNameLabel.textAlignment = .left
        recipeNameLabel.numberOfLines = 2
        recipeNameLabel.font = UIFont.boldSystemFont(ofSize: 80)
        recipeNameLabel.adjustsFontSizeToFitWidth = true
        recipeNameLabel.minimumScaleFactor = 0.01
        
        recipeDescriptionTextView.textContainerInset = UIEdgeInsets.zero
        recipeDescriptionTextView.textContainer.lineFragmentPadding = 0
        recipeDescriptionTextView.isEditable = false
        recipeDescriptionTextView.textColor = .gray
        recipeDescriptionTextView.font = UIFont.boldSystemFont(ofSize: 17)
        
        supportDescriptionLabel.text = "Описание:"
        supportDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            recipeImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor, multiplier: 1/2),
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 13),
            recipeNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeNameLabel.heightAnchor.constraint(equalTo: recipeNameLabel.widthAnchor, multiplier: 1/8),
            
            supportDescriptionLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 13),
            supportDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            supportDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            supportDescriptionLabel.heightAnchor.constraint(equalTo: supportDescriptionLabel.widthAnchor, multiplier: 1/12),
            
            recipeDescriptionTextView.topAnchor.constraint(equalTo: supportDescriptionLabel.bottomAnchor),
            recipeDescriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeDescriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeDescriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    func createNavBarStyle() {
        title = "Рецепт"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelItemButton))
    }
    
    @objc func cancelItemButton() {
        dismiss(animated: true)
    }
}
