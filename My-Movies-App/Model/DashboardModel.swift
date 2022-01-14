//
//  HomeModel.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 13/1/2565 BE.
//

import Foundation

// MARK: - HomeModelElement
struct DashboardModelElement: Decodable {
    let type, title, size: String
    let movies: [Movie]
}

// MARK: - Movie
struct Movie: Decodable {
    let id, title, name: String
    let imageURL: String
    let movieDescription: String
    let category: [Category]
    let language: [Language]
    let startDate: String
    let studioName: StudioName
    let imageUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case id, title, name
        case imageURL = "imageUrl"
        case movieDescription = "description"
        case category, language, startDate, studioName, imageUrls
    }
}

enum Category: String, Decodable {
    case action = "Action"
    case kids = "Kids"
    case superhero = "Superhero"
}

enum Language: String, Decodable {
    case english = "English"
    case hindi = "Hindi"
    case indonesian = "Indonesian"
    case malay = "Malay"
    case tamil = "Tamil"
    case thai = "Thai"
}

enum StudioName: String, Decodable {
    case marvel = "Marvel"
}

typealias DashboardModel = [DashboardModelElement]
