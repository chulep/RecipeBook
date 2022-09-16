//
//  ViewController.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 10.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createControllers()
        tabBarApperanse()
    }
    
    //MARK: - VC for TabBar
    private func createControllers() {
        viewControllers = [
            ModuleBuilder.createBookModule(),
            ModuleBuilder.createCalculationModule(),
            ModuleBuilder.createFavoritesModule()
        ]
    }
    
    //MARK: - TabBar style
    private func tabBarApperanse() {
        //прозрачный бэкграунд
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .clear
        
        //основное оформление
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let heigth = tabBar.bounds.height + positionOnY * 2
        
        let roundRect = CGRect(x: positionOnX,
                               y: tabBar.bounds.minY - positionOnY,
                               width: width,
                               height: heigth)
        
        let bezierPath = UIBezierPath(roundedRect: roundRect,
                                      cornerRadius: heigth / 4)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        shapeLayer.fillColor = UIColor.white.cgColor
        
        //бордер
        shapeLayer.lineWidth = 4
        shapeLayer.strokeColor = UIColor.orange.cgColor
        
        //цвет нажатой/отжатой кнопки
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
    }
    
}


