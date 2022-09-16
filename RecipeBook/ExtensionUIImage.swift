//
//  Extension UIImage.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 21.08.2022.
//

import UIKit

extension UIImage {
    
    static func createImage(data: Data?, fromURL: Bool) -> UIImage? {
        switch (data, fromURL) {
        case _ where fromURL == false && data == nil:
            return UIImage(systemName: "pencil.circle")
        case _ where fromURL == true && data == nil:
            return UIImage(systemName: "globe")
        default:
            return UIImage(data: data!)
        }
    }
    
    static func openImageData(data: Data?) -> UIImage {
        switch data {
        case _ where data != nil:
            return UIImage(data: data!)!
        default:
            return UIImage()
        }
    }
    
}
