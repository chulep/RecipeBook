//
//  SearchView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class SearchViewNew: UIView {
    
    private var button = UIButton()
    private var substrateView = UIView()
    var textField = UITextField()
    private let closeImage = UIImage(systemName: "multiply.circle")
    private let openImage = UIImage(systemName: "magnifyingglass.circle")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    private func createUI() {
        backgroundColor = .orange
        
        for i in [button, substrateView] {
            i.translatesAutoresizingMaskIntoConstraints = false
            addSubview(i)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        substrateView.addSubview(textField)
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        textField.backgroundColor = .white
        button.backgroundColor = .orange
        //button.setImage(openImage, for: .normal)
        button.tintColor = .white
        
        button.addTarget(nil, action: #selector(BookViewController.openSearchBar), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            substrateView.rightAnchor.constraint(equalTo: button.leftAnchor),
            substrateView.leftAnchor.constraint(equalTo: leftAnchor),
            substrateView.topAnchor.constraint(equalTo: topAnchor),
            substrateView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 5),
            textField.leftAnchor.constraint(equalTo: substrateView.leftAnchor, constant: 5),
            textField.rightAnchor.constraint(equalTo: substrateView.rightAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -5)
        ])
        
        
    }
    
    func openClose(condition: Bool) {
        switch condition {
        case true:
            button.setImage(closeImage, for: .normal)
            textField.layer.cornerRadius = textField.bounds.height / 2
        case false:
            button.setImage(openImage, for: .normal)
        }
    }
}
