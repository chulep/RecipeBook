//
//  BookViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class BookViewController: UIViewController {
    
    let searchButton = UIButton()
    let searchTextField = UITextField()
    var widthView = NSLayoutConstraint()
    lazy var searchSize = view.bounds.width / 8
    var searchIsOpen = false
    var newViewSearch = SearchViewNew()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        newSearchCreate()
    }
    
    private func newSearchCreate() {
        newViewSearch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newViewSearch)
        
        
        let searchSize = view.bounds.width / 8
        newViewSearch.heightAnchor.constraint(equalToConstant: searchSize).isActive = true
        newViewSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        newViewSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        widthView = newViewSearch.widthAnchor.constraint(equalToConstant: searchSize)
        widthView.isActive = true
    }
    
    private func createSearchButton() {
        searchButton.backgroundColor = .white
        searchButton.addTarget(self, action: #selector(openSearchBar), for: .touchUpInside)
        let image = UIImage(systemName: "magnifyingglass.circle")
        searchButton.setImage(image, for: .normal)
        searchButton.tintColor = .gray
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        let searchSize = view.bounds.width / 8
        searchButton.widthAnchor.constraint(equalToConstant: searchSize).isActive = true
        searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: searchSize).isActive = true
    }
    
    private func createSearchTextField() {
        searchTextField.backgroundColor = .white
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.borderStyle = .roundedRect
        view.addSubview(searchTextField)
        
        let searchSize = view.bounds.width / 8
        searchTextField.topAnchor.constraint(equalTo: searchButton.topAnchor).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: searchButton.leftAnchor).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: searchSize).isActive = true
        widthView = searchTextField.widthAnchor.constraint(equalToConstant: 0)
        widthView.isActive = true
        
    }
    
    @objc func openSearchBar() {
        var image = UIImage()
        switch searchIsOpen {
        case true:
            widthView.constant = searchSize
            image = UIImage(systemName: "magnifyingglass.circle")!
        case false:
            widthView.constant = view.bounds.width - 60 - searchSize
            image = UIImage(systemName: "multiply.circle")!
        }
        searchIsOpen = !searchIsOpen
        searchButton.setImage(image, for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.view.layoutIfNeeded()
            print("animate")
        }
    }
}
