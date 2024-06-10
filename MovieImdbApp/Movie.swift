import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let genreIDs: [Int]?
    let backdropPath: String?
    let runtime: Int?
    let director: String?
    let cast: [CastMember]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case runtime
        case director
        case cast
    }
}

struct CastMember: Codable {
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath = "profile_path"
    }
}

