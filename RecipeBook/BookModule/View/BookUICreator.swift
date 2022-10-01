//
//  BookUICreator.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 01.10.2022.
//

import UIKit
import CoreLocation

protocol BookUICreatorType {
    func createUICollectionView(bounds: CGRect) -> UICollectionView
    func createNothingLabel(bounds: CGRect) -> UILabel
    func createBlurView(bounds: CGRect) -> UIVisualEffectView
    func createAddNewRecipeButton() -> UIButton
    func addNewRecipeViewAnimate(isOpen: Bool?, bounds: CGRect, addView: UIView, blurView: UIView, navItem: UINavigationItem)
    func addButtonConstraintActivate(button: UIButton, parrentView: UIView)
    func circleRadius(view: UIView)
}

final class BookUICreator: BookUICreatorType {
    func createUICollectionView(bounds: CGRect) -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: bounds.width / 2 - 15, height: bounds.width / 2 + 30)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifire)
        collectionView.frame = bounds
        return collectionView
    }
    
    func createNothingLabel(bounds: CGRect) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorHelper.systemLightGray
        label.text = "Добавьте первый рецепт"
        label.frame = bounds
        return label
    }
    
    func createBlurView(bounds: CGRect) -> UIVisualEffectView {
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bounds
        return blurView
    }
    
    func createAddNewRecipeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = ColorHelper.systemOrange
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func addNewRecipeViewAnimate(isOpen: Bool?, bounds: CGRect, addView: UIView, blurView: UIView, navItem: UINavigationItem) {
        switch isOpen {
        case true:
            blurView.isHidden = false
            blurView.alpha = 0
            navItem.titleView?.isHidden = true
            UIView.animate(withDuration: 0.3, delay: 0) {
                addView.frame.origin.y = bounds.height - bounds.width / 1.6
                blurView.alpha = 0.9
            }
        case false:
            navItem.titleView?.isHidden = false
            blurView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0) {
                addView.frame.origin.y = bounds.height
                blurView.alpha = 0
            }
        default:
            addView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: bounds.width / 1.6)
            blurView.isHidden = true
            navItem.titleView?.isHidden = false
        }
    }
    
    func addButtonConstraintActivate(button: UIButton, parrentView: UIView) {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: parrentView.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            button.rightAnchor.constraint(equalTo: parrentView.rightAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: parrentView.bounds.width / 7),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
    
    func circleRadius(view: UIView) {
        view.layer.cornerRadius = view.bounds.height / 2
        view.clipsToBounds = true
    }
    
}
