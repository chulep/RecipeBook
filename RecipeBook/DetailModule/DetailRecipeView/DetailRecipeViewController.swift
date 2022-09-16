//
//  DetailRecipeViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 19.07.2022.
//

import UIKit
import WebKit

class DetailRecipeViewController: UIViewController {
    
    var recipeImageView: UIImageView?
    var recipeNameLabel: UILabel?
    var recipeDescriptionTextView: UITextView?
    private var supportDescriptionLabel: UILabel?
    private var UICreator: DetailUICreator?
    
    var webView: WKWebView?
    var activityIndicator = UIActivityIndicatorView()
    
    var delegate: reloadRecipeDelegate?
    var viewModel: DetailRecipeViewModelType?
    
    init(viewModel: DetailRecipeViewModelType, UICreator: DetailUICreator) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.UICreator = UICreator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancel))

        var buttonsArray = [UIBarButtonItem]()
        let favoriteItem = UIBarButtonItem(image: UICreator?.createFavoriteImage(favorite: viewModel!.favoriteRecipe), style: .plain, target: self, action: #selector(tapToFavorite))
        buttonsArray.append(favoriteItem)
        
        if viewModel?.forModule == .bookModule {
            let deleteItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteRecipe))
            buttonsArray.append(deleteItem)
        }
        
        let indicatorItem = UIBarButtonItem(customView: activityIndicator)
        buttonsArray.append(indicatorItem)
        
        navigationItem.setRightBarButtonItems(buttonsArray, animated: true)
    }
    
    //MARK: - Button method
    @objc func cancel() {
        webView?.stopLoading()
        webView = nil
        dismiss(animated: true)
        delegate?.updateListRecipe()
    }
    
    @objc func tapToFavorite() {
        viewModel?.tapToFavorite()
        createNavBarStyle()
    }
    
    @objc func deleteRecipe() {
        let alertController = UICreator?.createDeleteAlert(recipeName: viewModel?.name) { [unowned self] in
            self.viewModel?.deleteRecipe()
            cancel()
        }
        present(alertController!, animated: true)
    }
    
    //MARK: - Create offline detail UI
    func createOfflineUI() {
        view.backgroundColor = .white
        recipeImageView = UICreator?.createImageView(imageData: viewModel?.image)
        recipeNameLabel = UICreator?.createNameLabel(text: viewModel?.name)
        recipeDescriptionTextView = UICreator?.createTextView(text: viewModel?.description)
        supportDescriptionLabel = UICreator?.createSupportDescriptionLabel()
        
        for i in [recipeNameLabel, recipeDescriptionTextView, recipeImageView, supportDescriptionLabel] {
            i!.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i!)
        }
        
        var imageHeight = view.bounds.width / 2
        if viewModel?.image == nil {
            imageHeight = 0
        }
        
        NSLayoutConstraint.activate([
            recipeImageView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            recipeImageView!.leftAnchor.constraint(equalTo: view.leftAnchor),
            recipeImageView!.rightAnchor.constraint(equalTo: view.rightAnchor),
            recipeImageView!.heightAnchor.constraint(equalToConstant: imageHeight),
            
            recipeNameLabel!.topAnchor.constraint(equalTo: recipeImageView!.bottomAnchor, constant: 13),
            recipeNameLabel!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeNameLabel!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeNameLabel!.heightAnchor.constraint(equalTo: recipeNameLabel!.widthAnchor, multiplier: 1/8),
            
            supportDescriptionLabel!.topAnchor.constraint(equalTo: recipeNameLabel!.bottomAnchor, constant: 13),
            supportDescriptionLabel!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            supportDescriptionLabel!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            supportDescriptionLabel!.heightAnchor.constraint(equalTo: supportDescriptionLabel!.widthAnchor, multiplier: 1/12),
            
            recipeDescriptionTextView!.topAnchor.constraint(equalTo: supportDescriptionLabel!.bottomAnchor),
            recipeDescriptionTextView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipeDescriptionTextView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recipeDescriptionTextView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    //MARK: - Create online detail UI
    func createOnlineUI() {
        webView = WKWebView()
        view.addSubview(webView!)
        webView?.frame = view.bounds
        webView?.navigationDelegate = self
        
        //Alert, если ссылка битая
        guard let exLink = viewModel?.exURL else { return }
        if UIApplication.shared.checkURL(urlString: exLink) == false {
            let alertController = UICreator?.createWarningAlert(urlString: exLink) { [unowned self] delete in
                switch delete {
                case false:
                    self.cancel()
                case true:
                    self.viewModel?.deleteRecipe()
                    self.cancel()
                }
            }
            present(alertController!, animated: true)
        }
        
        //Открываем, если ссылка рабочая
        guard let url = URL(string: exLink) else { return }
        let urlRequest = URLRequest(url: url)
        webView?.load(urlRequest)
    }
    
}

//MARK: - WKWebView navigation delegate
extension DetailRecipeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        navigationItem.titleView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.titleView = nil
        activityIndicator.stopAnimating()
    }
    
}
