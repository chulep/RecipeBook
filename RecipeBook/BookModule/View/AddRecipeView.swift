//
//  AddRecipeView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class AddRecipeView: UIView {
    
    var addLinkButton = UIButton()
    var addIndependButton = UIButton()
    private var openButton = UIButton()
    private var substrateView = UIView()
    private var subWallView = UIView()
    private let closeImage = UIImage(systemName: "multiply.circle")
    private let openImage = UIImage(systemName: "plus.circle")
    private lazy var sizeButton = bounds.height
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        openButton.setImage(openImage, for: .normal)
    }
    
    private func createUI() {
        backgroundColor = .orange
        
        for i in [subWallView, substrateView] {
            i.translatesAutoresizingMaskIntoConstraints = false
            addSubview(i)
        }
        
        openButton.translatesAutoresizingMaskIntoConstraints = false
        subWallView.addSubview(openButton)
        
        for i in [addLinkButton, addIndependButton] {
            i.translatesAutoresizingMaskIntoConstraints = false
            substrateView.addSubview(i)
        }
        
        subWallView.backgroundColor = .orange
        openButton.backgroundColor = .orange
        openButton.tintColor = .white
        
        addLinkButton.setImage(UIImage(systemName: "globe")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: sizeButton)), for: .normal)
        addLinkButton.tintColor = .white
        addLinkButton.setTitle("Из интернета", for: .normal)
        
        addIndependButton.setImage(UIImage(systemName: "pencil.tip.crop.circle")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: sizeButton)), for: .normal)
        addIndependButton.tintColor = .white
        addIndependButton.setTitle("Вручную", for: .normal)
        
        addIndependButton.addTarget(nil, action: #selector(BookViewController.buttonadd), for: .touchUpInside)
        addLinkButton.addTarget(nil, action: #selector(BookViewController.buttonadd2), for: .touchUpInside)
        
        openButton.addTarget(nil, action: #selector(BookViewController.openAddRecipe), for: .touchUpInside)
        NSLayoutConstraint.activate([
            subWallView.rightAnchor.constraint(equalTo: rightAnchor),
            subWallView.topAnchor.constraint(equalTo: topAnchor),
            subWallView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subWallView.widthAnchor.constraint(equalToConstant: sizeButton),
            
            openButton.rightAnchor.constraint(equalTo: rightAnchor),
            openButton.topAnchor.constraint(equalTo: topAnchor),
            openButton.heightAnchor.constraint(equalToConstant: sizeButton),
            openButton.widthAnchor.constraint(equalToConstant: sizeButton),
            
            substrateView.rightAnchor.constraint(equalTo: openButton.leftAnchor),
            substrateView.leftAnchor.constraint(equalTo: leftAnchor),
            substrateView.topAnchor.constraint(equalTo: topAnchor),
            substrateView.bottomAnchor.constraint(equalTo: bottomAnchor),

            addLinkButton.topAnchor.constraint(equalTo: substrateView.topAnchor),
            addLinkButton.leftAnchor.constraint(equalTo: substrateView.leftAnchor, constant: sizeButton),
            addLinkButton.widthAnchor.constraint(equalToConstant: (substrateView.bounds.width - sizeButton) / 2),
            addLinkButton.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor),

            addIndependButton.topAnchor.constraint(equalTo: substrateView.topAnchor),
            addIndependButton.leftAnchor.constraint(equalTo: addLinkButton.rightAnchor),
            addIndependButton.widthAnchor.constraint(equalTo: addLinkButton.widthAnchor),
            addIndependButton.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor)
        ])
        bringSubviewToFront(subWallView)
    }
    
    func openClose(condition: Bool) {
        switch condition {
        case true:
            openButton.setImage(closeImage, for: .normal)
        case false:
            openButton.setImage(openImage, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
