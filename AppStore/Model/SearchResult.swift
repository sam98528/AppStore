//
//  SearchResult.swift
//  AppStore
//
//  Created by Sam.Lee on 4/17/24.
//

import Foundation

struct SearchResult : Codable {
    let resultCount : Int
    let results: [App]
}

extension SearchResult {
    static var data : [App] = []
}
