//
//  CalculetionViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 24.08.2022.
//

import Foundation

protocol CalculetionViewModelType {
    func calculate(buttonTag: Int, segmentIndex: Int, completion: (String, String, String) -> Void)
    init(model: CalculateModel)
}

class CalculationViewModel: CalculetionViewModelType {
    
    private var model: CalculateModel
    private var cup = "0"
    private var spoon = "0"
    private var gram = "0" {
        didSet {
            if (Int(gram) ?? 0) > 9999 {
                gram = oldValue
            }
        }
    }
    
    //MARK: - Init
    required init(model: CalculateModel) {
        self.model = model
    }
    
    
    //MARK: - Methods
    func calculate(buttonTag: Int, segmentIndex: Int, completion: (String, String, String) -> Void) {
        
        switch buttonTag {
        case 10:
            gram = "0"
        default:
            if gram == "0" { gram = "" }
            gram.append("\(buttonTag)")
        }
        
        let set = Double(gram)!
        switch segmentIndex {
        case 0:
            //мука
            cup = String(Double(round(10 * set / model.flourCup) / 10))
            spoon = String(Double(round(10 * set / model.flourSpoon) / 10))
        case 1:
            //сахар
            cup = String(Double(round(10 * set / model.sugarCup) / 10))
            spoon = String(Double(round(10 * set / model.sugarSpoon) / 10))
        case 2:
            //крупы
            cup = String(Double(round(10 * set / model.grainCup) / 10))
            spoon = String(Double(round(10 * set / model.grainSpoon) / 10))
        default:
            break
        }
        
        completion(gram, cup, spoon)
    }
    
}
