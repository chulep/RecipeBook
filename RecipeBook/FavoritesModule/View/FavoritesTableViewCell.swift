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

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    private func createUI() {
        recipeName.text = viewModel?.name
        recipeImageView.image = UIImage(systemName: "globe")
        
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
