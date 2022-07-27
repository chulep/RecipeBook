//
//  BookModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation
import UIKit

final class RecipeModel {
    var name: String
    var incomingInternet: Bool
    var description: String?
    var image: UIImage?
    var exLink: URL?
    var save = false
    
    init(name: String, incomingInternet: Bool, description: String?, exLink: URL?, image: UIImage?) {
        self.name = name
        self.incomingInternet = incomingInternet
        self.description = description
        self.exLink = exLink
        self.image = image
        
        if self.image == nil {
            self.image = UIImage(systemName: "globe")
        }
    }
    
}
