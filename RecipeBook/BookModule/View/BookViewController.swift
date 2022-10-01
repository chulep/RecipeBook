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

final class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    private var blurView = UIVisualEffectView()
    private var buttonIsOpen = false
    private var addButtonView = AddButtonView()
    private var addButton = UIButton()
    private var searchBar = UISearchBar()
    private var collectionView: UICollectionView?
    private var viewModel: BookViewModelType?
    private var nothingLabel: UILabel?
    private var UICreator: BookUICreatorType?
    
    //MARK: - Init
    convenience init(viewModel: BookViewModelType, UICreator: BookUICreatorType) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.UICreator = UICreator
    }

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.exportAllRecipes()
        collectionView?.reloadData()
        
        if viewModel?.recipeCount == 0 {
            nothingLabel = UICreator?.createNothingLabel(bounds: view.bounds)
            view.addSubview(nothingLabel!)
        } else {
            nothingLabel?.isHidden = true
        }
        
        UICreator?.addNewRecipeViewAnimate(isOpen: nil, bounds: view.bounds, addView: addButtonView, blurView: blurView, navItem: navigationItem)
        
        addButton.layer.cornerRadius = addButton.bounds.height / 2
        addButton.clipsToBounds = true
    }
    
    //MARK: - Create UI
    private func createUI() {
        view.backgroundColor = .white
        collectionView = UICreator?.createUICollectionView(bounds: view.bounds)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        addButton = UICreator!.createAddNewRecipeButton()
        addButton.addTarget(self, action: #selector(self.buttonAddOpen), for: .touchUpInside)
        
        blurView = UICreator!.createBlurView(bounds: view.bounds)
        
        for i in [collectionView!, addButton, blurView, addButtonView] {
            view.addSubview(i)
        }
        
        UICreator?.addButtonConstraintActivate(button: addButton, parrentView: view)

        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAddOpen))
        blurView.addGestureRecognizer(tap)
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
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
        guard let detailViewModel = viewModel?.detailRecipeViewModel(forIdexPath: indexPath) else { return }
        let detailVC = ModuleBuilder.createDetailModule(viewModel: detailViewModel)
        present(detailVC, animated: true)
    }
    
    //MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchRecipe(text: searchText)
        collectionView?.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel?.searchRecipe(text: searchBar.text!)
        collectionView?.reloadData()
    }
    
    //MARK: - Add View Open
    @objc func buttonAddOpen() {
        buttonIsOpen = !buttonIsOpen
        searchBar.resignFirstResponder()
        UICreator?.addNewRecipeViewAnimate(isOpen: buttonIsOpen, bounds: view.bounds, addView: addButtonView, blurView: blurView, navItem: navigationItem)
    }
    
    //MARK: - Open Add ViewController
    @objc func openNewVC(_ button: UIButton) {
        switch button.tag {
        case 1:
            present(ModuleBuilder.createAddRecipeModule(action: .url), animated: true)
        case 2:
            present(ModuleBuilder.createAddRecipeModule(action: .inddepend), animated: true)
        default:
            break
        }
    }
    
}

//MARK: - Add Recipe Delegate
extension BookViewController: reloadRecipeDelegate {
    func updateListRecipe() {
        viewModel?.exportAllRecipes()
        collectionView?.reloadData()
    }
    
}
