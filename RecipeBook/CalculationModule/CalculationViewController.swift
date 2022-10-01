//
//  CalculationViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class CalculationViewController: UIViewController {
    
    var numberPadView: NumberPadView?
    var viewModel: CalculetionViewModelType?
    var displayView: DisplayView?
    var productSegment = UISegmentedControl(items: ["мука", "сахар", "крупы"])
    
    //MARK: - Init
    init(viewModel: CalculetionViewModelType, numberPadView: NumberPadView, displayView: DisplayView) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.numberPadView = numberPadView
        self.displayView = displayView
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    //MARK: - UI
    private func createUI() {
        guard let numberPadView = numberPadView, let displayView = displayView else { return }
        view.backgroundColor = .white

        for i in [numberPadView, displayView, productSegment] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        
        productSegment.backgroundColor = ColorHelper.systemLightGray
        productSegment.selectedSegmentIndex = 0
        productSegment.addTarget(self, action: #selector(selectSegment(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            displayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            displayView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            displayView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            displayView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height / 12),
            
            productSegment.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height / 12),
            productSegment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            productSegment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
            productSegment.heightAnchor.constraint(equalToConstant: view.bounds.height / 24),
            
            numberPadView.topAnchor.constraint(equalTo: productSegment.bottomAnchor, constant: 7),
            numberPadView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            numberPadView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7),
            numberPadView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7),
        ])
    }
    
    //MARK: - Selectors
    @objc func tapButton(_ button: UIButton) {
        viewModel?.calculate(buttonTag: button.tag, segmentIndex: productSegment.selectedSegmentIndex) { [unowned self] gram, cup, spoon in
            self.displayView?.showValue(gram: gram, cup: cup, spoon: spoon)
        }
    }
    
    @objc func selectSegment(_ sender: UISegmentedControl) {
        viewModel?.calculate(buttonTag: 10, segmentIndex: sender.selectedSegmentIndex) { [unowned self] gram, cup, spoon in
            self.displayView?.showValue(gram: gram, cup: cup, spoon: spoon)
        }
    }
    
    //MARK: - Other
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
