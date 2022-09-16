//
//  ModuleBuilder.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 01.09.2022.
//

import UIKit

protocol ModuleBuilderType {
    
}

struct ModuleBuilder: ModuleBuilderType {
    
    static func createTabBarController() -> UITabBarController {
        let tabBarContreoller = TabBarController()
        return tabBarContreoller
    }
    
    static func createNavigationBarApperance(backgroundColor: UIColor, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : textColor]
    }
    
    static func createBookModule() -> UINavigationController {
        let viewController = BookViewController()
        viewController.tabBarItem.title = "Рецепты"
        viewController.tabBarItem.image = UIImage(systemName: "book")
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.backgroundColor = .orange
        return navController
    }
    
    static func createAddRecipeViewController(action: AddRecipeViewController.Action) -> UINavigationController {
        let viewController = AddRecipeViewController(action: action)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
    static func createCalculationModule() -> CalculationViewController {
        let model = CalculateModel()
        let viewModel = CalculationViewModel(model: model)
        let displayView = DisplayView()
        let numberPadView = NumberPadView()
        let viewController = CalculationViewController(viewModel: viewModel, numberPadView: numberPadView, displayView: displayView)
        viewController.tabBarItem.title = "Весы"
        viewController.tabBarItem.image = UIImage(systemName: "scalemass")
        return viewController
    }
    
    static func createFavoritesModule() -> FavoritesViewController {
        let coreData = CoreDataInteraction()
        let viewModel = FavoritesViewModel(coreData: coreData)
        let viewController = FavoritesViewController(viewModel: viewModel)
        viewController.title = "Избранное"
        viewController.tabBarItem.image = UIImage(systemName: "heart")
        return viewController
    }
    
    static func createDetailModule(viewModel: DetailRecipeViewModelType) -> UINavigationController {
        let detailUICreator = DetailUICreator()
        let viewController = DetailRecipeViewController(viewModel: viewModel, UICreator: detailUICreator)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
}
