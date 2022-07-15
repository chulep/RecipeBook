//
//  BookViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var widthSearchView = NSLayoutConstraint()
    var widthAddRecipeView = NSLayoutConstraint()
    var heightAddRecipeView = NSLayoutConstraint()
    lazy var buttonSize = view.bounds.width / 9
    var searchIsOpen = false
    var addRecipeIsOpen = false
    var searchView = CustomSearchView()
    var addRecipeView = AddRecipeView()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var bookArray: [BookModel] = [BookModel(name: "кура", incomingInternet: true, description: nil, exLink: nil, image: nil), BookModel(name: "картоха", incomingInternet: true, description: nil, exLink: nil, image: nil), BookModel(name: "пирог", incomingInternet: true, description: nil, exLink: nil, image: nil), BookModel(name: "котлетыыыыыыыыыыыыыыыыыыыыыыыы", incomingInternet: true, description: nil, exLink: nil, image: nil)]
    private var bookArrayFiltr = [BookModel]()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        createUI()
    }
    
    //MARK: - Create UI
    private func createUI() {
        view.backgroundColor = .white
        bookArrayFiltr = bookArray
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        searchView.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        widthSearchView = searchView.widthAnchor.constraint(equalToConstant: buttonSize)
        widthSearchView.isActive = true
        
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = buttonSize / 2
        //
        addRecipeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addRecipeView)
        
        addRecipeView.topAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 20).isActive = true
        addRecipeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        heightAddRecipeView = addRecipeView.heightAnchor.constraint(equalToConstant: buttonSize)
        widthAddRecipeView = addRecipeView.widthAnchor.constraint(equalToConstant: buttonSize)
        widthAddRecipeView.isActive = true
        heightAddRecipeView.isActive = true
        
        addRecipeView.clipsToBounds = true
        addRecipeView.layer.cornerRadius = buttonSize / 2
    }
    
    //MARK: - CollectionView Settings
    private func settingCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 + 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: settingCollectionViewLayout())
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifire)
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: - CollectionView DataSource/Delegate
    //dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookArrayFiltr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifire, for: indexPath) as! BookCollectionViewCell
        cell.layer.cornerRadius = cell.bounds.height / 10
        cell.nameLabel.text = bookArrayFiltr[indexPath.row].name
        cell.imageView.image = bookArrayFiltr[indexPath.row].image
        return cell
    }
    //delegate

    //MARK: - Search Method
    @objc func searchViewMethod() {
        if searchView.textField.text == "" {
            bookArrayFiltr = bookArray
        } else {
            bookArrayFiltr = bookArray.filter({ return String($0.name).lowercased().contains(searchView.textField.text?.lowercased() ?? "")
            })
        }
        collectionView.reloadData()
    }
    
    @objc func buttonadd() {
        let VC = AddIndependViewController()
        let navVC = UINavigationController(rootViewController: VC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.backgroundColor = .orange
        present(navVC, animated: true)
    }
}
