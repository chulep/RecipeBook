//
//  DisplayView.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 26.08.2022.
//

import UIKit

class DisplayView: UIView {
    
    private let gramSupportLabel = UILabel()
    private let gramResultLabel = UILabel()
    private let cupSupportLabel = UILabel()
    private let cupResultLabel = UILabel()
    private let spoonSuppertLabel = UILabel()
    private let spoonResultLabel = UILabel()
    private lazy var width = bounds.width / 2
    private lazy var height = bounds.height / 3
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in [cupResultLabel, cupSupportLabel, spoonResultLabel, spoonSuppertLabel, gramSupportLabel, gramResultLabel] {
            i.backgroundColor = UIColorHelper.systemLightGray
            i.textAlignment = .center
            addSubview(i)
            i.layer.cornerRadius = bounds.width / 3 / 9
            i.clipsToBounds = true
        }
        
        gramSupportLabel.text = "Граммы"
        gramResultLabel.layer.borderColor = UIColor.orange.cgColor
        gramResultLabel.layer.borderWidth = 2
        gramSupportLabel.frame = CGRect(x: 0, y: 0, width: width - 4, height: height - 4)
        gramResultLabel.frame = CGRect(x: width + 4, y: 0, width: width - 4, height: height - 4)
        
        cupSupportLabel.text = "Стаканы\n(200-250 мл)"
        cupSupportLabel.numberOfLines = 2
        cupSupportLabel.frame = CGRect(x: 0, y: height + 2, width: width - 4, height: height - 4)
        cupResultLabel.frame = CGRect(x: width + 4, y: height + 2, width: width - 4, height: height - 4)
        
        spoonSuppertLabel.text = "Столовые ложки"
        spoonSuppertLabel.frame = CGRect(x: 0, y: height * 2 + 4, width: width - 4, height: height - 4)
        spoonResultLabel.frame = CGRect(x: width + 4, y: height * 2 + 4, width: width - 4, height: height - 4)
    }
    
    func setText(gram: String, cup: String, spoon: String) {
        gramResultLabel.text = gram
        cupResultLabel.text = cup
        spoonResultLabel.text = spoon
        
        gramResultLabel.alpha = 0.8
        UIView.animate(withDuration: 0.2) {
            self.gramResultLabel.alpha = 1
        }
    }
    
}
