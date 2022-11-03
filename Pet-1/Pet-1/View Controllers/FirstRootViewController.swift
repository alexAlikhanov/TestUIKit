//
//  ViewController.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

class FirstRootViewController: BasicFirstNavigator {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addNextButton()
    }
    private func addNextButton() {
        let button = UIButton()
        button.setTitle("Next page", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(nextButtonAction(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 80),
            ])
    }
    
    @objc func nextButtonAction(sender: UIButton){
        navigator?.show(.vc12)
    }

}

