//
//  Extentions.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

extension SceneDelegate: UITabBarControllerDelegate {
    
    func createImageTabBar() {
        let myImage = MainNavigator.shared.tabBar.tabBar.subviews.first
        myImageView = myImage?.subviews.first as? UIImageView
        let myImage2 = MainNavigator.shared.tabBar.tabBar.subviews[1]
        myImageView2 = myImage2.subviews.first as? UIImageView
    }
    
    func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        lastTag = viewController.tabBarItem.tag
        switch viewController.tabBarItem.tag {
        case 0  where lastTag != 1 : animate(myImageView)
            viewController.tabBarController?.tabBar.tintColor = .blue
        case 1  where lastTag != 0 : animate(myImageView2)
            viewController.tabBarController?.tabBar.tintColor = .red
            default: return true
        }
        lastTag = viewController.tabBarItem.tag
        return true
    }
}
