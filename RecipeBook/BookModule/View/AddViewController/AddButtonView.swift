//
//  AddButtonView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 11.09.2022.
//

import UIKit

class AddButtonView: UIView {
    
    private let internetButton = UIButton()
    private let independButton = UIButton()
    private var buttonClosed = UIButton()
    private let stack = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColorHelper.systemMediumGray
        
        addSubview(buttonClosed)
        buttonClosed.setTitle("Закрыть", for: .normal)
        buttonClosed.frame = CGRect(x: 5, y: 0, width: bounds.width / 5, height: bounds.width / 9)
        buttonClosed.addTarget(nil, action: #selector(BookViewController.buttonAddOpen), for: .touchUpInside)
        
        internetButton.setTitle("Из интернета", for: .normal)
        independButton.setTitle("Вручную", for: .normal)
        internetButton.tag = 1
        independButton.tag = 2
        
        addSubview(stack)
        for i in [independButton, internetButton] {
            stack.addArrangedSubview(i)
            i.backgroundColor = UIColorHelper.systemOrange
            i.bounds.size = CGSize(width: bounds.width / 2 - 100, height: bounds.width / 2 - 100)
            i.addTarget(nil, action: #selector(BookViewController.openNewVC(_:)), for: .touchUpInside)
        }
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.frame = CGRect(x: 10, y: buttonClosed.bounds.height + 5, width: bounds.width - 20, height: bounds.width / 4 - 20)
        
        independButton.layer.cornerRadius = independButton.bounds.width / 4
        internetButton.layer.cornerRadius = independButton.bounds.width / 4
    }

}
