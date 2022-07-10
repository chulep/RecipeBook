//
//  BookViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class BookViewController: UIViewController {
    
    var widthView = NSLayoutConstraint()
    lazy var searchSize = view.bounds.width / 9
    var searchIsOpen = false
    var newViewSearch = SearchViewNew()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newSearchCreate()
    }
    
    private func newSearchCreate() {
        newViewSearch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newViewSearch)
        
        newViewSearch.heightAnchor.constraint(equalToConstant: searchSize).isActive = true
        newViewSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        newViewSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        widthView = newViewSearch.widthAnchor.constraint(equalToConstant: searchSize)
        widthView.isActive = true
        
        newViewSearch.clipsToBounds = true
        newViewSearch.layer.cornerRadius = searchSize / 2
    }
    
    @objc func openSearchBar() {
        switch searchIsOpen {
        case true:
            widthView.constant = searchSize
        case false:
            widthView.constant = view.bounds.width - 60
        }
        searchIsOpen = !searchIsOpen
        newViewSearch.openClose(condition: searchIsOpen)
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.view.layoutIfNeeded()
            print("animate")
        } completion: { end in
            self.newViewSearch.textField.text = ""
        }
    }
}
