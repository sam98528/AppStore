//
//  AppModel.swift
//  AppStore
//
//  Created by Sam.Lee on 4/17/24.
//

import Foundation
import Alamofire

protocol SearchModelDelegate {
    func dataRetrived()
}
class SearchModel {
    let urlString = "https://itunes.apple.com/search?country=kr&entity=software"
    var delegate : SearchModelDelegate?
    
    func getRepoAlamofire(with title: String){
        let url = URL(string: "\(urlString)&term=\(title)")!
        AF.request(url).response{ response in
            switch response.result{
            case .success(let data):
                do{
                    let newSearchResult = try JSONDecoder().decode(SearchResult.self, from: data!)
                    SearchResult.data = newSearchResult.results
                    DispatchQueue.main.async {            
                        self.delegate?.dataRetrived()
                    }
                }catch let error {
                    print("ERROR PARSING JSON: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
