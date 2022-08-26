//
//  NumberPadView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 26.08.2022.
//

import UIKit

class NumberPadView: UIView {
    var button1 = CustomUIButton()
    var button2 = CustomUIButton()
    var button3 = CustomUIButton()
    var button4 = CustomUIButton()
    var button5 = CustomUIButton()
    var button6 = CustomUIButton()
    var button7 = CustomUIButton()
    var button8 = CustomUIButton()
    var button9 = CustomUIButton()
    var button0 = CustomUIButton()
    var buttonC = CustomUIButton()
    lazy var cornerRadius = bounds.width / 3 / 9
    lazy var buttonWidth = bounds.width / 3
    lazy var buttonHeight = bounds.height / 4
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in [button1, button2, button3, button4, button5, button6, button7, button8, button9, button0, buttonC] {
            i.backgroundColor = .orange
            addSubview(i)
            i.layer.cornerRadius = cornerRadius
            i.addTarget(nil, action: #selector(CalculationViewController.tapButton(_:)), for: .touchUpInside)
        }
        
        button1.setTitle("1", for: .normal)
        button2.setTitle("2", for: .normal)
        button3.setTitle("3", for: .normal)
        button4.setTitle("4", for: .normal)
        button5.setTitle("5", for: .normal)
        button6.setTitle("6", for: .normal)
        button7.setTitle("7", for: .normal)
        button8.setTitle("8", for: .normal)
        button9.setTitle("9", for: .normal)
        button0.setTitle("0", for: .normal)
        buttonC.setTitle("C", for: .normal)
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        button5.tag = 5
        button6.tag = 6
        button7.tag = 7
        button8.tag = 8
        button9.tag = 9
        button0.tag = 0
        buttonC.tag = 10
        
        //1ряд
        button1.frame = CGRect(x: 0, y: 0, width: buttonWidth - 4, height: buttonHeight - 4)
        button2.frame = CGRect(x: buttonWidth + 2, y: 0, width: buttonWidth - 4, height: buttonHeight - 4)
        button3.frame = CGRect(x: buttonWidth * 2 + 4, y: 0, width: buttonWidth - 4, height: buttonHeight - 4)
        //2ряд
        button4.frame = CGRect(x: 0, y: buttonHeight + 2, width: buttonWidth - 4, height: buttonHeight - 4)
        button5.frame = CGRect(x: buttonWidth + 2, y: buttonHeight + 2, width: buttonWidth - 4, height: buttonHeight - 4)
        button6.frame = CGRect(x: buttonWidth * 2 + 4, y: buttonHeight + 2, width: buttonWidth - 4, height: buttonHeight - 4)
        //3ряд
        button7.frame = CGRect(x: 0, y: buttonHeight * 2 + 3, width: buttonWidth - 4, height: buttonHeight - 4)
        button8.frame = CGRect(x: buttonWidth + 2, y: buttonHeight * 2 + 3, width: buttonWidth - 4, height: buttonHeight - 4)
        button9.frame = CGRect(x: buttonWidth * 2 + 4, y: buttonHeight * 2 + 3, width: buttonWidth - 4, height: buttonHeight - 4)
        //4ряд
        button0.frame = CGRect(x: 0, y: buttonHeight * 3 + 4, width: buttonWidth * 2 - 2, height: buttonHeight - 4)
        buttonC.frame = CGRect(x: buttonWidth * 2 + 4, y: buttonHeight * 3 + 4, width: buttonWidth - 4, height: buttonHeight - 4)
    }

}
