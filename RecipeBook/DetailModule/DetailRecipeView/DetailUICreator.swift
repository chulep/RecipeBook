//
//  UICreator.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.09.2022.
//

import UIKit

final class DetailUICreate {
    func createImageView(imageData: Data?) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColorHelper.systemLightGray
        imageView.tintColor = .white
        imageView.image = UIImage.openImageData(data: imageData)
        return imageView
    }
    
    func createNameLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        label.text = text
        return label
    }
    
    func createSupportDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Описание:"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }
    
    func createTextView(text: String?) -> UITextView {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.isEditable = false
        textView.textColor = UIColorHelper.systemMediumGray
        textView.font = UIFont.boldSystemFont(ofSize: 17)
        textView.text = text
        return textView
    }
    
    func createAlert(url: String, completion: @escaping (Bool) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Не удалось открыть ссылку:", message: url, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Назад", style: .default) { action in
            completion(false)
        }
        let actionDelete = UIAlertAction(title: "Удалить", style: .default) { action in
            completion(true)
        }
        alertController.addAction(actionDelete)
        alertController.addAction(actionCancel)
        
        return alertController
    }
    
}
