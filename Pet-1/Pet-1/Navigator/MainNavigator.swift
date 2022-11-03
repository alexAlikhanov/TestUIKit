//
//  MainNavigatigator.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

protocol MainNavigatorProtocol {
    func initialViewController() -> UIViewController
}
protocol Navigator {
    associatedtype Distination
    func show(_ distination: Distination)
}

class MainNavigator {
    var tabBar: UITabBarController
    static let shared = MainNavigator()
    private var navigations: [MainNavigatorProtocol]
    //private let animateDelegate = ViewController()
    init(){
        tabBar = UITabBarController()
        navigations = [FirstFlowNavigator(), SecondFlowNavigator()]
        let controllers = navigations.map({$0.initialViewController()})
        let barItem1 = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        controllers[0].tabBarItem = barItem1
        let barItem2 = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 1)
        controllers[0].tabBarItem = barItem1
        controllers[1].tabBarItem = barItem2
        tabBar.setViewControllers(controllers, animated: true)

    }
}




