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
    
    private var blurView = UIVisualEffectView()
    private var buttonIsOpen = false
    var addButtonView = AddButtonView()
    var addButton = UIButton()
    var collectionView: UICollectionView?
    var viewModel: BookViewModelType?
    private var searchBar = UISearchBar()
    private var nothingLabel = UILabel()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BookViewModel()
        createCollectionView()
        createUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAddOpen))
        blurView.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addButton.layer.cornerRadius = addButton.bounds.height / 2
        addButton.clipsToBounds = true
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
        addButtonView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.width / 1.6)
        blurView.isHidden = true
        navigationItem.titleView?.isHidden = false
        buttonIsOpen = false
    }
    
    //MARK: - Create UI
    private func createUI() {
        
        view.addSubview(nothingLabel)
        nothingLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 8)
        nothingLabel.textAlignment = .center
        nothingLabel.center = view.center
        nothingLabel.textColor = UIColorHelper.systemLightGray
        nothingLabel.text = "Добавьте первый рецепт"
        
        view.addSubview(addButton)
        addButton.backgroundColor = UIColorHelper.systemOrange
        addButton.addTarget(self, action: #selector(self.buttonAddOpen), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 7),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor)
        ])
        
        let blur = UIBlurEffect(style: .extraLight)
        blurView = UIVisualEffectView(effect: blur)
        view.addSubview(blurView)
        blurView.frame = view.bounds
        
        view.addSubview(addButtonView)
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        view.backgroundColor = .white
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
        guard let detailViewModel = viewModel?.detailRecipeViewModel(forIdexPath: indexPath) else { return }
        let detailVC = ModuleBuilder.createDetailModule(viewModel: detailViewModel)
        present(detailVC, animated: true)
    }
    
    //MARK: - Search Method
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
        switch buttonIsOpen {
        case true:
            blurView.isHidden = false
            blurView.alpha = 0
            navigationItem.titleView?.isHidden = true
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.addButtonView.frame.origin.y = self.view.bounds.height - self.view.bounds.width / 1.6
                self.blurView.alpha = 0.7
            }
        case false:
            navigationItem.titleView?.isHidden = false
            blurView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.addButtonView.frame.origin.y = self.view.bounds.height
                self.blurView.alpha = 0
            }
        }
    }
    
    //MARK: - Open Add ViewController
    @objc func openNewVC(_ button: UIButton) {
        switch button.tag {
        case 1:
            present(ModuleBuilder.createAddRecipeViewController(action: .url), animated: true)
        case 2:
            present(ModuleBuilder.createAddRecipeViewController(action: .inddepend), animated: true)
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
