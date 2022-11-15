//
//  MusicSearchVC.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import UIKit

class MusicSearchVC: UIViewController {
    private let networkDataFetcher = NetworkDataFetcher()
    private var searchResponse: SearchResponse? = nil
    private var favoriteTracks: [Track] = []
    private var searchTableView = UITableView()
    private var tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    private var searchText = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createTableView()
        setupSearchBar()
        UserDefaultsManager.shared.loadData(forKey: UserDefaultsManager.shared.userDefaultsKey) { [weak self] (tracks) in
            self?.favoriteTracks = tracks
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupConstraints()
    }
    private func setupConstraints(){
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: searchController.view.safeAreaLayoutGuide.topAnchor),
            searchTableView.centerXAnchor.constraint(equalTo: searchController.view.safeAreaLayoutGuide.centerXAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: searchController.view.safeAreaLayoutGuide.bottomAnchor),
            searchTableView.widthAnchor.constraint(equalToConstant: searchController.view.safeAreaLayoutGuide.layoutFrame.size.width)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.size.width)
        ])
    }
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.title = "My music"
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.view.backgroundColor = .white
    }
    private func createTableView(){
        searchTableView = UITableView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 100), style: .plain)
        searchTableView.register(MusicViewCell.self, forCellReuseIdentifier: "cell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.separatorStyle = .none
        searchTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchTableView.tag = 1
        searchController.view.addSubview(searchTableView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 100), style: .plain)
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tag = 0
        view.addSubview(tableView)
    }
    
}

extension MusicSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return searchResponse?.results.count ?? 0
        } else if tableView.tag == 0 {
            return favoriteTracks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MusicViewCell else {
            print("return")
            return UITableViewCell()}
        if tableView.tag == 1 {
            let track = searchResponse?.results[indexPath.row]
            cell.config(data: track)
        }
        if tableView.tag == 0 {
            let track = favoriteTracks[indexPath.row]
            cell.config(data: track)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            guard let track = searchResponse?.results[indexPath.row] else { return }
            favoriteTracks.append(track)
            self.tableView.reloadData()
            UserDefaultsManager.shared.save(favoriteTracks)
        }
        if tableView.tag == 0 {
          
            MusicPlayer.shared.setupPlayer(stringURL: favoriteTracks[indexPath.row].previewUrl)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.tag == 0 { return true } else { return false }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.tag == 0 { return .delete } else { return .delete }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, tableView.tag == 0 {
            favoriteTracks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            UserDefaultsManager.shared.save(favoriteTracks)
        }
    }
}

extension MusicSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = ""
        for char in searchText {
            if char == " " { self.searchText += "+"} else {
                self.searchText += String (char)
            }
        }
        let urlString = "https://itunes.apple.com/search?term=\(self.searchText)&limit=20"

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.searchResponse = searchResponse
                self.searchTableView.reloadData()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResponse = nil
        self.searchTableView.reloadData()
        self.tableView.reloadData()
    }
}
