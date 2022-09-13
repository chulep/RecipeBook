//
//  DetailRecipeViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 19.07.2022.
//

import UIKit
import WebKit

class DetailRecipeViewController: UIViewController {
    
    var recipeImageView = UIImageView()
    var recipeNameLabel = UILabel()
    var recipeDescriptionTextView = UITextView()
    private var supportDescriptionLabel: UILabel?
    private var favoriteImage: UIImage?
    private var createHelper = DetailUICreate()
    
    var webView: WKWebView?
    var activityIndicator: UIActivityIndicatorView?
    
    var delegate: reloadRecipeDelegate?
    var viewModel: DetailRecipeViewModelType? 
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBarStyle()
        
        if viewModel?.exURL == nil {
            createOfflineUI()
        } else {
            createOnlineUI()
        }
        
    }
    
    //MARK: - Navigation bar
    func createNavBarStyle() {
        title = "Рецепт"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelItemButton))
        
        switch viewModel!.favoriteRecipe {
        case true:
            favoriteImage = UIImage(systemName: "heart.fill")
        case false:
            favoriteImage = UIImage(systemName: "heart")
        }
        
        var buttonArray = [UIBarButtonItem]()
        activityIndicator = UIActivityIndicatorView()
        let favoriteItem = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(tapToFavorite))
        buttonArray.append(favoriteItem)
        
        if viewModel?.forModule == .bookModule {
            let deleteItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteObject))
            buttonArray.append(deleteItem)
        }
        
        let indicatorItem = UIBarButtonItem(customView: activityIndicator!)
        buttonArray.append(indicatorItem)
        
        navigationItem.setRightBarButtonItems(buttonArray, animated: true)
    }
    
    @objc func cancelItemButton() {
        webView?.stopLoading()
        dismiss(animated: true)
        delegate?.updateListRecipe()
    }
    
    @objc func tapToFavorite() {
        viewModel?.tapToFavorite()
        createNavBarStyle()
    }
    
    @objc func deleteObject() {
        let alertController = UIAlertController(title: "Хотите удалить рецепт?", message: "\(String(describing: viewModel?.name))", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Отмена", style: .default) { action in
            alertController.dismiss(animated: true)
        }
        let actionDelete = UIAlertAction(title: "Удалить", style: .default) { action in
            self.viewModel?.deleteRecipe()
            self.cancelItemButton()
        }
        alertController.addAction(actionDelete)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }
    
    //MARK: - Create offline detail UI
    func createOfflineUI() {
        view.backgroundColor = .white
        recipeImageView = createHelper.createImageView(imageData: viewModel?.image)
        recipeNameLabel = createHelper.createNameLabel(text: viewModel?.name)
        recipeDescriptionTextView = createHelper.createTextView(text: viewModel?.description)
        supportDescriptionLabel = createHelper.createSupportDescriptionLabel()
        
        for i in [recipeNameLabel, recipeDescriptionTextView, recipeImageView, supportDescriptionLabel] {
            i!.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i!)
        }
        
        var imageHeight = view.bounds.width / 2
        if viewModel?.image == nil {
            imageHeight = 0
        }
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            recipeImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 13),
            recipeNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeNameLabel.heightAnchor.constraint(equalTo: recipeNameLabel.widthAnchor, multiplier: 1/8),
            
            supportDescriptionLabel!.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 13),
            supportDescriptionLabel!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            supportDescriptionLabel!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            supportDescriptionLabel!.heightAnchor.constraint(equalTo: supportDescriptionLabel!.widthAnchor, multiplier: 1/12),
            
            recipeDescriptionTextView.topAnchor.constraint(equalTo: supportDescriptionLabel!.bottomAnchor),
            recipeDescriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeDescriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeDescriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    //MARK: - Create online detail UI
    func createOnlineUI() {
        webView = WKWebView()
        view.addSubview(webView!)
        webView?.frame = view.bounds
        webView?.navigationDelegate = self
        guard let exLink = viewModel?.exURL else { return } // если писать на руском то выкидывает через урл { ретёрн }
        if UIApplication.shared.checkURL(urlString: exLink) == false {
            let alertController = UIAlertController(title: "Не удалось открыть ссылку:", message: "\(exLink)", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Назад", style: .default) { action in
                self.cancelItemButton()
            }
            let actionDelete = UIAlertAction(title: "Удалить", style: .default) { action in
                self.viewModel?.deleteRecipe()
                self.cancelItemButton()
            }
            alertController.addAction(actionDelete)
            alertController.addAction(actionCancel)
            present(alertController, animated: true)
        }
        guard let url = URL(string: exLink) else { return }
        let urlRequest = URLRequest(url: url)
        webView?.load(urlRequest)
    }
    
}

//MARK: - WKWebView navigation delegate
extension DetailRecipeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator?.isHidden = true
        activityIndicator?.stopAnimating()
    }
    
}
