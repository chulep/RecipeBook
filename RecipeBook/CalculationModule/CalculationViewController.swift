//
//  CalculationViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class CalculationViewController: UIViewController {
    
    var viewModel = CalculationViewModel()
    var displayView = DisplayView()
    var productSegment = UISegmentedControl(items: ["мука", "сахар", "крупы"])
    var numberPad = NumberPadView()
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
    }
    
    private func createUI() {
        view.backgroundColor = .white
        numberPad.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberPad)
        displayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(displayView)
        productSegment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productSegment)
        productSegment.backgroundColor = UIColorHelper.systemLightGray
        productSegment.selectedSegmentIndex = 0
        
        NSLayoutConstraint.activate([
            displayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            displayView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            displayView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            displayView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            
            productSegment.bottomAnchor.constraint(equalTo: numberPad.topAnchor, constant: -7),
            productSegment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            productSegment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            productSegment.heightAnchor.constraint(equalToConstant: view.bounds.height / 24),
            
            numberPad.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            numberPad.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            numberPad.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            numberPad.heightAnchor.constraint(equalToConstant: view.bounds.height / 4)
        ])
    }
    
    @objc func tapButton(_ button: UIButton) {
        viewModel.calculate(buttonTag: button.tag, segmentIndex: productSegment.selectedSegmentIndex)
        displayView.setText(gram: viewModel.gram, cup: String(viewModel.cup), spoon: String(viewModel.spoon))
    }
    
}
