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
    let releaseNotes: String?
    let version: String?
    
    // ScreenShots
    let screenshotUrls: [String]
    
    // Description
    let description: String
    let artistViewUrl: String
    
    let primaryGenreName: String
    let fileSizeBytes: String
    let sellerUrl: String?
    let formattedPrice: String?
    let minimumOsVersion: String
    
    enum CodingKeys : String, CodingKey{
        case appTitle = "trackName"
        case appIconImage = "artworkUrl512"
        case sellerName
        case trackViewUrl
        case userRatingCount
        case averageUserRating
        case trackContentRating
        case artistName
        case releaseNotes
        case version
        case screenshotUrls
        case description
        case artistViewUrl
        case primaryGenreName
        case fileSizeBytes
        case sellerUrl
        case formattedPrice
        case minimumOsVersion
    }
}
