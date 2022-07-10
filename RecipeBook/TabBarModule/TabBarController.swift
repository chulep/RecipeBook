//
//  ViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        tabBarApperanse()
    }

    private func createTabBar() {
        
        viewControllers = [
            createVC(viewController: BookViewController(), title: "Рецепты", imageSystemName: "book"),
            createVC(viewController: CalculationViewController(), title: "Весы", imageSystemName: "scalemass"),
            createVC(viewController: FavoritesViewController(), title: "Избранное", imageSystemName: "heart")
        ]
    }
    
    private func createVC(viewController: UIViewController, title: String, imageSystemName: String) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: imageSystemName)
        return viewController
    }
    
    private func tabBarApperanse() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let heigth = tabBar.bounds.height + positionOnY * 2
        
        let roundRect = CGRect(x: positionOnX,
                               y: tabBar.bounds.minY - positionOnY,
                               width: width,
                               height: heigth)
        
        let bezierPath = UIBezierPath(roundedRect: roundRect,
                                      cornerRadius: heigth / 2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        shapeLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }

}

