//
//  ViewController.swift
//  Pet-1
//
//  Created by Алексей on 11/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var imageView2: UIImageView!
    private var image: [UIImage] = [UIImage(), UIImage()]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("viewdidload")
        loadData()
//        fetchImage()
//        fetchImage2()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initImageView()
        imageView.image = image[0]

    }
    
    private func initImageView(){
        imageView = UIImageView()
        imageView.frame = CGRect(x: 50, y: 0, width: 150, height: 150)
        imageView.center.y = view.center.y
        imageView.backgroundColor = .darkGray
        imageView.image = image[0]
        view.addSubview(imageView)
        imageView2 = UIImageView()
        imageView2.frame = CGRect(x: 250, y: 0, width: 150, height: 150)
        imageView2.center.y = view.center.y
        imageView2.backgroundColor = .darkGray
        imageView2.image = image[1]
        view.addSubview(imageView2)
    }
    // classic
    private func loadData(){
        let imageURL = URL(string: "https://i.redd.it/096oc5ubc5381.jpg")!
       let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            print("start")
           if let data = try? Data(contentsOf: imageURL) {
               print("load")
                DispatchQueue.main.async {
                    print("show")
                    self.image[0] = UIImage(data: data)!
                    self.imageView.image = self.image[0]
                }
            }
            else {
                print("error load")
            }
        }
    }
    // Used DispatchWorkItem
    private func fetchImage(){
        print("DispatchWorkItem start")
        let imageURL = URL(string: "https://i.redd.it/096oc5ubc5381.jpg")!
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        let worlItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: imageURL)
            print(Thread.current)
        }
        queue.async(execute: worlItem)
        worlItem.notify(queue: .main) {
            if let imageData = data {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    // Used URLSession
    private func fetchImage2(){
        print("URLSession started")
        let imageURL = URL(string: "https://i.redd.it/096oc5ubc5381.jpg")!
        let task = URLSession.shared.dataTask(with: imageURL) { data, response , error  in
            print(Thread.current)
            if let imageData = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}

