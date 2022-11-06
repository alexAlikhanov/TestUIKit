//
//  ViewController.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("viewdidload")
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initImageView()
    }
    
    private func initImageView(){
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        imageView.backgroundColor = .darkGray
        imageView.image = image
        view.addSubview(imageView)
    }
    
    private func loadData(){
        let imageURL = URL(string: "https://i.redd.it/096oc5ubc5381.jpg")!
       let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            print("start")
           if let data = try? Data(contentsOf: imageURL) {
               print("load")
                DispatchQueue.main.async {
                    print("show")
                    self.image = UIImage(data: data)
                    self.imageView.image = self.image
                }
            }
            else {
                print("error load")
            }
        }
    }
}

