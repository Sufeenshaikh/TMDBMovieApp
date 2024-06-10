import UIKit
import CustomNetworkSDK

class latestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var latestTableView: UITableView!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        latestTableView.delegate = self
        latestTableView.dataSource = self
        
        
        fetchLatestMovies()
    }
    
    func fetchLatestMovies() {
        TMDBServices.shared.fetchLatestMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.latestTableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "latestCell", for: indexPath) as! latestTableViewCell
        let movie = movies[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.dateTitle.text = movie.releaseDate
        if let posterPath = movie.posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.movieImg.loadImage(from: imageUrl)
        } else {
            cell.movieImg.image = UIImage(named: "placeholderImage")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMovieID = movies[indexPath.row].id
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? detailViewController {
            detailVC.movieID = selectedMovieID
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else {
            self.image = UIImage(named: "placeholderImage")
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
