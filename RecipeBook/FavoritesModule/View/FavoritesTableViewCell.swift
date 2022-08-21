//
//  TableViewCell.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 14.08.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifire = "FavoriteCell"
    let recipeImageView = UIImageView()
    let recipeName = UILabel()
    var viewModel: FavoritesCellViewModelType?
    private lazy var radius = bounds.height / 10

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    
    private func createUI() {
        
        for i in [recipeImageView, recipeName] {
            addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.leftAnchor.constraint(equalTo: leftAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            
            recipeName.topAnchor.constraint(equalTo: topAnchor),
            recipeName.leftAnchor.constraint(equalTo: recipeImageView.rightAnchor),
            recipeName.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeName.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        recipeImageView.layer.cornerRadius = radius
        recipeImageView.clipsToBounds = true
        recipeImageView.tintColor = UIColorHelper.systemLightGray
        recipeImageView.contentMode = .scaleAspectFill
        
        recipeName.numberOfLines = 2
        
        guard let viewModel = viewModel else { return }
        recipeName.text = viewModel.name
        recipeImageView.image = UIImage.createImage(data: viewModel.image, fromURL: viewModel.fromURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        selectedBackgroundView = backgroundView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isSelected = false
        }
    }

}
