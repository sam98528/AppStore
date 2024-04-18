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
    var searchController : UISearchController!
    var searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfigure()
        searchModel.delegate = self
        tableViewConfigure()
//        setupfirstView()
        setupfirstView()
        //searchModel.getRepoAlamofire(with: "카카오톡")
        
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
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResult.data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBigCell.identifier, for: indexPath) as? SearchBigCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func setupfirstView() {
        let emptyStateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: searchTableView.bounds.size.width, height: searchTableView.bounds.size.height))
        emptyStateLabel.text = "아무거나 검색해보세용"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .label
        emptyStateLabel.font = .boldSystemFont(ofSize: 23)
        searchTableView.backgroundView = (SearchResult.data.count == 0 ? emptyStateLabel : nil)
    }
    
    func setupStateView(term: String) {
        let emtpyView = UIView(frame: CGRect(x: 0, y: 0, width: searchTableView.bounds.size.width, height: searchTableView.bounds.size.height))
        let emptyLabel = UILabel()
        emptyLabel.text = "결과 없음"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .label
        emptyLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        
        let termLabel = UILabel()
        termLabel.text = "'\(term)'"
        termLabel.textAlignment = .center
        termLabel.textColor = .secondaryLabel
        termLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        emtpyView.addSubview(emptyLabel)
        emtpyView.addSubview(termLabel)
        
        emptyLabel.snp.makeConstraints{make in
            make.centerY.leading.trailing.equalTo(emtpyView)
        }
        termLabel.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(35)
            
        }
        searchTableView.backgroundView = (SearchResult.data.count == 0 ? emtpyView : nil)
    }
}

extension SearchViewController : SearchModelDelegate {
    func dataRetrived() {
        setupStateView(term : searchController.searchBar.text ?? "")
        self.searchTableView.reloadData()
        self.searchController.isActive = false
    }
}

extension SearchViewController : UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchModel.getRepoAlamofire(with: searchText)
        }
        
    }
    
    
}
