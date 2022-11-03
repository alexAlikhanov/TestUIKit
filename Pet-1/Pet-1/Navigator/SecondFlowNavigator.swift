//
//  SecondFlowNavigator.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

class SecondFlowNavigator {
    
    private let navigationController: UINavigationController
    
    init() {
        let rootVC : UIViewController = SecondRootViewController()
        navigationController = UINavigationController(rootViewController: rootVC)
        
        if let vc = rootVC as? BasicSecondNavigator {
            vc.navigator = self
        }
    }
}

extension SecondFlowNavigator: MainNavigatorProtocol{
    func initialViewController() -> UIViewController {
        return navigationController
    }
}

extension SecondFlowNavigator: Navigator {
    
    enum Distination {

        case vc21
        case vc22
        case vc23
    }
    func show(_ distination: Distination) {
        let distVC: UIViewController!
        print("2")
        switch distination {
        case .vc21:
            distVC = SecondRootViewController()
        case .vc22:
            distVC = SecondRootViewController()
        case .vc23:
            distVC = SecondRootViewController()
        }
        
        navigationController.pushViewController(distVC, animated: true)
        if let vc = distVC as? BasicSecondNavigator {
            vc.navigator = self
        }
    }
    
    
}
