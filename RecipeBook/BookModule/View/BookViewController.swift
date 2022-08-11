//
//  BookViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

protocol reloadRecipeDelegate: AnyObject {
    func updateListRecipe()
}

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
    var collectionView: UICollectionView?
    var viewModel: BookViewModelType?

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BookViewModel()
        createCollectionView()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Create UI
    private func createUI() {
        view.backgroundColor = .white
        
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
        collectionView?.reloadData()
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
        collectionView?.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifire)
        collectionView?.frame = view.bounds
        view.addSubview(collectionView!)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    //MARK: - CollectionView DataSource/Delegate
    //dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.recipeCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifire, for: indexPath) as! BookCollectionViewCell
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.layer.cornerRadius = cell.bounds.height / 10
        cell.viewModel = viewModel.bookCellViewModel(forIdexPath: indexPath)
        return cell
    }
    
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let detailVC = DetailRecipeViewController()
        detailVC.delegate = self
        detailVC.viewModel = viewModel.detailRecipeViewModel(forIdexPath: indexPath)
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    //MARK: - Search Method
    @objc func searchViewMethod() {
        viewModel?.searchRecipe(text: searchView.textField.text ?? "")
        collectionView?.reloadData()
    }
    
    @objc func buttonadd() {
        let VC = AddIndependViewController()
        VC.delegate = self
        let navVC = UINavigationController(rootViewController: VC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.backgroundColor = .orange
        present(navVC, animated: true)
    }
    
    @objc func buttonadd2() {
        let VC = AddLinkViewController()
        VC.delegate = self
        let navVC = UINavigationController(rootViewController: VC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.backgroundColor = .orange
        present(navVC, animated: true)
    }
    
}

//MARK: - Add Recipe Delegate
extension BookViewController: reloadRecipeDelegate {
    func updateListRecipe() {
        viewModel?.exportAllRecipes()
        collectionView?.reloadData()
    }
    
}
