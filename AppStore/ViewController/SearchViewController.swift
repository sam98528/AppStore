//
//  SearchViewController.swift
//  AppStore
//
//  Created by Sam.Lee on 4/15/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController{

    var searchTableView: UITableView!
    var searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfigure()
        tableViewConfigure()
        searchModel.getRepoAlamofire(with: "kakao")
        
    }
    
    func tableViewConfigure(){
        self.searchTableView  = {
            let tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(SearchBigCell.nib(), forCellReuseIdentifier: SearchBigCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false

            //tableView.refreshControl = UIRefreshControl()
            //tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
            return tableView
        }()
        self.view.addSubview(searchTableView)
        self.searchTableView.snp.makeConstraints{make in
            make.bottom.leading.trailing.top.equalToSuperview()
        }
    }
    func searchBarConfigure(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        self.navigationItem.searchController = searchController
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResult.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBigCell.identifier, for: indexPath) as? SearchBigCell else {
            return UITableViewCell()
        }
        cell.configure(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

extension SearchViewController : SearchModelDelegate {
    func dataRetrived() {
        self.searchTableView.reloadData()
    }
}
