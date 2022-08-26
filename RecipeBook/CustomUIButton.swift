//
//  CustomUIButton.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 26.08.2022.
//

import UIKit

class CustomUIButton: UIButton {
    override var isHighlighted: Bool {
            didSet {
                guard let color = backgroundColor else { return }
                layer.removeAllAnimations()
                UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations: {
                    self.backgroundColor = color.withAlphaComponent(self.isHighlighted ? 0.3 : 1)
            })
        }
    }
}
