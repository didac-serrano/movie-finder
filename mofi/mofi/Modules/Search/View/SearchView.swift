//
//  SearchView.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 01/12/2021.
//

import UIKit
import ImageLoader

class SearchView: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {

    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    private var movies = [MovieEntity]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //No additional init needed
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSettings()
        searchBarSettings()
    }
    
    // MARK: - Setups
    func searchBarSettings() {
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.placeholder = "Type a title or theme..."
        self.searchBar.layer.cornerRadius = 8.0
    }
    
    func tableSettings() {
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.tableView.allowsSelection = true
        self.tableView.rowHeight = 282
        self.tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var sections = 0
        if self.movies.count > 0 {
            sections = 1
            self.tableView.backgroundView = nil
        }
        else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No recent searches"
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView = noDataLabel
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        cell.picture?.backgroundColor = .black
        if let url = URL(string: movie.picture!) {
            cell.picture?.load.request(with: url)
        }
        cell.title?.text = movie.title
        cell.info?.text = movie.getInfo()
        cell.contentView.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) != nil else { return }
        self.presenter?.perform(action: .itemSelected(index: indexPath.row))
    }
    
    // MARK: - RoomsViewProtocol
    func populate(_ state: SearchState) {
        switch state {
        case .success(let entity):
            self.movies = entity
            self.tableView.reloadData()
        case .error(let error):
            print(error) //TBD
        }
    }
}

// MARK: - Delegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // if the text change and is zero chars means user used cross button
        if searchText.count == 0 {
            self.movies.removeAll()
            self.tableView.reloadData()
        }
        // omdbapi does exact matching and needs +3 characters input
        // for testing purposes i use "seven"
        if searchText.count < 5 { return }
        self.presenter?.perform(action: .textEntered(text: searchText))
    }
}
