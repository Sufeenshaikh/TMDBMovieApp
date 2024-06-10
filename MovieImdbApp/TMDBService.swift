import Foundation
import CustomNetworkSDK

class TMDBServices {
    static let shared = TMDBServices()
    
    func fetchLatestMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKeys.tmdbAPIKey)") else {
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKeys.tmdbAPIKey)&language=en-US&page=1") else {
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(APIKeys.tmdbAPIKey)&append_to_response=credits"
        guard let url = URL(string: urlString) else { return }

        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieDetails = try decoder.decode(Movie.self, from: data)
                    completion(.success(movieDetails))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
