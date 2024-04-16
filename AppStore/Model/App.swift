//
//  App.swift
//  AppStore
//
//  Created by Sam.Lee on 4/15/24.
//

import Foundation

struct App : Codable {
    // Default Information
    let appTitle: String
    let appIconImage: String
    let sellerName: String
    let trackViewUrl : String
    
    // Rating
    let userRatingCount: Int
    let averageUserRating: Double
    
    // Age
    let trackContentRating: String
    
    // Developer
    let artistName: String
    
    // ReleaseNote
    let relaseNotes: String
    let version: String
    
    // ScreenShots
    let screenShotsUrl: [String]
    
    // Description
    let description: String
    let artistUrl: String
    
    let primaryGenreName: String
    let price: Double
    let fileSizeBytes: Int
    let sellerURL: String
    let formattedPrice: String
    let minimumOsVersion: String
}
