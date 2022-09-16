//
//  ExtencionURL.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.09.2022.
//

import UIKit

extension UIApplication {
    
    func checkURL(urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
}
