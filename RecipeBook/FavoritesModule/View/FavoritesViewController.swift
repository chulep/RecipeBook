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

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    func createUI() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView!)
        tableView?.backgroundColor = .white
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifire)
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

}
