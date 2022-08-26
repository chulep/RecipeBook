//
//  CalculetionViewModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 24.08.2022.
//

import Foundation

protocol CalculetionViewModelType {
    func calculate(buttonTag: Int, segmentIndex: Int)
}

class CalculationViewModel: CalculetionViewModelType {
    
    var cup: Double = 0
    var spoon: Double = 0
    var gram = "" {
        didSet {
            if (Int(gram) ?? 0) > 9999 {
                gram = oldValue
            }
        }
    }
    
    func calculate(buttonTag: Int, segmentIndex: Int) {
        
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
            cup = Double(round(10 * set / 145) / 10)
            spoon = Double(round(10 * set / 30) / 10)
        case 1:
            //сахар
            cup = Double(round(10 * set / 190) / 10)
            spoon = Double(round(10 * set / 25) / 10)
        case 2:
            //крупы
            cup = Double(round(10 * set / 240) / 10)
            spoon = Double(round(10 * set / 20) / 10)
        default:
            break
        }
    }
    
}
