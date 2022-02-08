// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dashboardModel = try? newJSONDecoder().decode(DashboardModel.self, from: jsonData)

import Foundation

// MARK: - DashboardModelElement
struct DashboardModelElement: Decodable {
    let type, title, size: String
    let movies: [Movie]
}

// MARK: - More
struct More: Decodable {
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
    let trailer: Trailer?
    let more: More?

    enum CodingKeys: String, CodingKey {
        case id, title, name
        case imageURL = "imageUrl"
        case movieDescription = "description"
        case category, language, startDate, studioName, imageUrls, trailer, more
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

// MARK: - Trailer
struct Trailer: Decodable {
    let videoURL, imageURL: String

    enum CodingKeys: String, CodingKey {
        case videoURL = "videoUrl"
        case imageURL = "imageUrl"
    }
}

typealias DashboardModel = [DashboardModelElement]
