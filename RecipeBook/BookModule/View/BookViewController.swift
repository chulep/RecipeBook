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

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    private var buttonIsOpen = false
    var addButtonView = AddButtonView()
    var addButton = UIButton()
    var collectionView: UICollectionView?
    var viewModel: BookViewModelType?
    private var searchBar = UISearchBar()
    private lazy var nothingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 8))

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BookViewModel()
        createCollectionView()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.exportAllRecipes()
        collectionView?.reloadData()
        
        if viewModel?.recipeCount == 0 {
            nothingLabel.isHidden = false
        } else {
            nothingLabel.isHidden = true
        }
        addButtonView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.width)
    }
    
    //MARK: - Create UI
    private func createUI() {
        
        view.addSubview(addButton)
        addButton.backgroundColor = UIColorHelper.systemOrange
        addButton.frame = CGRect(x: 10, y: view.bounds.height - 160, width: view.bounds.width / 8, height: view.bounds.width / 8)
        addButton.addTarget(self, action: #selector(self.buttonAddOpen), for: .touchUpInside)
        addButton.layer.cornerRadius = addButton.bounds.height / 2
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        view.addSubview(addButtonView)
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(nothingLabel)
        nothingLabel.textAlignment = .center
        nothingLabel.center = view.center
        nothingLabel.textColor = UIColorHelper.systemMediumGray
        nothingLabel.text = "Добавьте первый рецепт"
    }
    
    //MARK: - CollectionView Settings
    private func settingCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 + 30)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchRecipe(text: searchText)
        collectionView?.reloadData()
    }
    
    //MARK: - Add Open
    @objc func buttonAddOpen() {
        buttonIsOpen = !buttonIsOpen
        
        switch buttonIsOpen {
        case true:
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.addButtonView.frame.origin.y = self.view.bounds.height - self.view.bounds.width
            }
        case false:
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.addButtonView.frame.origin.y = self.view.bounds.height
            }
        }
    }
    
    @objc func openNewVC(_ button: UIButton) {
        switch button.tag {
        case 1:
            present(ModuleBuilder.addViewController(action: .url), animated: true)
        case 2:
            present(ModuleBuilder.addViewController(action: .inddepend), animated: true)
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
