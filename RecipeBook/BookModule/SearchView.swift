//
//  SearchView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class SearchViewNew: UIView {
    
    var button = UIButton()
    var textField = UITextField()
    private var size = CGFloat()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in [button, textField] {
            i.translatesAutoresizingMaskIntoConstraints = false
            addSubview(i)
        }
        backgroundColor = .white
        textField.backgroundColor = .orange
        button.backgroundColor = .red
        createUI()
    }
    
    private func createUI() {
        button.addTarget(nil, action: #selector(BookViewController.openSearchBar), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            textField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -5),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            textField.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5)
        ])
        
    }

}
