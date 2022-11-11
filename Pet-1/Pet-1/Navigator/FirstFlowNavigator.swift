//
//  FirstFlowNAvigator.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

class FirstFlowNavigator {
     let navigationController: UINavigationController

    init() {
        let rootVC : UIViewController = FirstRootViewController()
        navigationController = UINavigationController(rootViewController: rootVC)
        
        if let vc = rootVC as? BasicFirstNavigator {
            vc.navigator = self
        }
    }
}

extension FirstFlowNavigator: MainNavigatorProtocol {
    func initialViewController() -> UIViewController {
        return navigationController
    }
}

extension FirstFlowNavigator: Navigator {
    
    enum Distination {

        case vc11
        case vc12
        case vc13
    }
    
    func show(_ distination: Distination) {
        var distVC : UIViewController = FirstRootViewController()
        print("1")
        switch distination {
        case .vc11:
            distVC = FirstRootViewController()
        case .vc12:
            distVC = ViewController()
        case .vc13:
            distVC = TableViewController()
        }
        
        navigationController.pushViewController(distVC, animated: true)
        
        if let vc = distVC as? BasicFirstNavigator {
            vc.navigator = self
        }
    }
    
    
}
