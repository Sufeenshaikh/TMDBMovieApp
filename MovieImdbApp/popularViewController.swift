import UIKit

class popularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var popularTableView: UITableView!

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularTableView.dataSource = self
        popularTableView.delegate = self
        
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        TMDBServices.shared.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.popularTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching popular movies: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! popularTableViewCell
        
        let movie = movies[indexPath.row]
        cell.movieTitle.text = movie.title
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.movieImg.load(url: posterURL) // Ensure this line matches the load function signature
        } else {
            cell.movieImg.image = UIImage(named: "placeholderImage")
        }
        cell.dateTitle.text = movie.releaseDate
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMovieID = movies[indexPath.row].id
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? detailViewController {
            detailVC.movieID = selectedMovieID
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension UIImageView {
    func load(url: URL?) {
        guard let url = url else {
            self.image = UIImage(named: "placeholderImage")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
