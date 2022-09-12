//
//  ModuleBuilder.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 01.09.2022.
//

import UIKit

protocol ModuleBuilderType {
    static func calculationModule() -> CalculationViewController
    static func favoritesModule() -> FavoritesViewController
}

struct ModuleBuilder: ModuleBuilderType {
    
    static func bookModule() -> UINavigationController {
        let viewController = BookViewController()
        viewController.tabBarItem.title = "Рецепты"
        viewController.tabBarItem.image = UIImage(systemName: "book")
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.backgroundColor = .orange
        return navController
    }
    
    static func addViewController(action: AddRecipeViewController.Action) -> UINavigationController {
        let viewController = AddRecipeViewController(action: action)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
    static func calculationModule() -> CalculationViewController {
        let model = CalculateModel()
        let viewModel = CalculationViewModel(model: model)
        let displayView = DisplayView()
        let numberPadView = NumberPadView()
        let viewController = CalculationViewController(viewModel: viewModel, numberPadView: numberPadView, displayView: displayView)
        viewController.tabBarItem.title = "Весы"
        viewController.tabBarItem.image = UIImage(systemName: "scalemass")
        return viewController
    }
    
    static func favoritesModule() -> FavoritesViewController {
        let coreData = CoreDataInteraction()
        let viewModel = FavoritesViewModel(coreData: coreData)
        let viewController = FavoritesViewController(viewModel: viewModel)
        viewController.title = "Избранное"
        viewController.tabBarItem.image = UIImage(systemName: "heart")
        return viewController
    }
    
}
