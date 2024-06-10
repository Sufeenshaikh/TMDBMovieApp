//
//  detailViewController.swift
//  MovieImdbApp
//
//  Created by Dr. Mac on 06/06/24.
//

import UIKit
import CustomNetworkSDK

class detailViewController: UIViewController {
    

    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var containerViewBig: UIView!
    @IBOutlet weak var containerViewSmall: UIView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    
    var movieID: Int?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImg.layer.cornerRadius = 14.0
        containerViewBig.layer.cornerRadius = 14.0
        containerViewBig.layer.borderColor = #colorLiteral(red: 0.8512551188, green: 0.8502929211, blue: 0.8472214937, alpha: 1)
        containerViewBig.layer.borderWidth = 2.0
    
        
        if let movieID = movieID {
                    fetchMovieDetails(movieID: movieID)
                }
        
            }

    
        
    private func updateUI() {
           guard let movie = movie else { return }
           
           movieTitle.text = movie.title
        if let releaseDate = movie.releaseDate {
                    dateLabel.text = extractYear(from: releaseDate)
                }
           overviewLabel.text = movie.overview
           hourLabel.text = movie.runtime != nil ? "\(movie.runtime!) mins" : "N/A"
           directorLabel.text = movie.director ?? "N/A"
           
           if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
               movieImg.loadImage(from: url)
           }
       }
    
    func extractYear(from dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                return String(year)
            }
            return nil
        }

       private func fetchMovieDetails(movieID: Int) {
           TMDBServices.shared.fetchMovieDetails(movieID: movieID) { [weak self] result in
               switch result {
               case .success(let movie):
                   print("Fetched movie details: \(movie)") // Debug print statement
                   self?.movie = movie
                   DispatchQueue.main.async {
                       self?.updateUI()
                   }
               case .failure(let error):
                   print("Failed to fetch movie details: \(error)")
               }
           }
       }
   }

   extension UIImageView {
       func loadImage(from url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self?.image = image
                   }
               }
           }
       }
   }
    

