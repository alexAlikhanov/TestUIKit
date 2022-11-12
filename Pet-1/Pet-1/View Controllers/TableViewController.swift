//
//  TableViewController.swift
//  Pet-1
//
//  Created by Алексей on 11/10/22.
//

import UIKit

class TableViewController: UIViewController {
    
    private let identifire = "Cell"
    private var myTableView = UITableView()
    private var networkManager = NetworkManager()
    private var posts: [PostModel] = []
    private var photos: [PhotoModel] = []
    private var refresh = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "TVC"
        view.backgroundColor = .white
        createTableView()
        refresh.addTarget(self, action: #selector(hendleRefresh(param:)), for: .valueChanged )
        loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func createTableView(){
        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: identifire)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.addSubview(refresh)
        view.addSubview(myTableView)
    }
    
    @objc func hendleRefresh(param: UIRefreshControl){
        loadData()
    }
    
    private func loadData(){
        networkManager.getAllPosts { [weak self](posts) in
            DispatchQueue.main.async {
                self?.posts = posts
                self?.refresh.endRefreshing()
                self?.myTableView.reloadData()
            }
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifire, for: indexPath) as? TableViewCell else { return UITableViewCell()}
        cell.postData = posts[indexPath.row]
        cell.config()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
