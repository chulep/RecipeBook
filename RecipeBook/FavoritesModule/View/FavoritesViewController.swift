//
//  FavoritesViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    let viewModel = FavoritesViewModel()
    lazy var nothingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 8))

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.exportAllRecipes()
        tableView?.reloadData()
        
        if viewModel.recipeCount == 0 {
            nothingLabel.isHidden = false
        } else {
            nothingLabel.isHidden = true
        }
    }

    func createUI() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView!)
        tableView?.backgroundColor = .white
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifire)
        
        view.addSubview(nothingLabel)
        nothingLabel.textAlignment = .center
        nothingLabel.center = view.center
        nothingLabel.textColor = UIColorHelper.systemMediumGray
        nothingLabel.text = "Нет избранных рецептов"
    }
    
    //MARK: - TableView Delegate/DataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recipeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifire, for: indexPath) as! FavoritesTableViewCell
        cell.viewModel = viewModel.favoritesCellViewModel(forIdexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = viewModel.detailRecipeViewModel(forIdexPath: indexPath)
        let detailVC = DetailRecipeViewController()
        detailVC.viewModel = detailViewModel
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

}
