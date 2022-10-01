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
        
        backgroundColor = ColorHelper.systemMediumGray
        
        addSubview(buttonClosed)
        buttonClosed.setTitle("Закрыть", for: .normal)
        buttonClosed.frame = CGRect(x: bounds.width - buttonClosed.bounds.width - 5, y: 0, width: bounds.width / 5, height: bounds.width / 9)
        buttonClosed.addTarget(nil, action: #selector(BookViewController.buttonAddOpen), for: .touchUpInside)
        
        internetButton.setTitle("По ссылке", for: .normal)
        independButton.setTitle("Вручную", for: .normal)
        internetButton.tag = 1
        independButton.tag = 2
        
        addSubview(stack)
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.frame = CGRect(x: 10, y: buttonClosed.bounds.height + 5, width: bounds.width - 20, height: bounds.width / 4 - 20)
        
        for i in [independButton, internetButton] {
            stack.addArrangedSubview(i)
            i.backgroundColor = ColorHelper.systemOrange
            i.bounds.size = CGSize(width: bounds.width / 2 - 100, height: bounds.width / 2 - 100)
            i.addTarget(nil, action: #selector(BookViewController.openNewVC(_:)), for: .touchUpInside)
            i.layer.cornerRadius = stack.bounds.height / 4
        }
    }

}
