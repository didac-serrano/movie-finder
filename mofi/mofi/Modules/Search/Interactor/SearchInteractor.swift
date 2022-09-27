//
//  SearchInteractor.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    
    var selectedMovie: MovieEntity?
    var movies: [MovieEntity]?

    var presenter: SearchInteractorOutputProtocol?
    var dataManager: SearchAPIDataManagerProtocol?
    
    init() { self.dataManager = SearchAPIDataManager() }
    
    func perform(_ job: SearchJob) {
        switch job {
        case .requestMovies(let text): fetchMovies(text: text)
        case .requestMovieDetail(let index): fetchMovieDetail(index: index)
        case .deleteMovie(let index): movies?.remove(at: index)
        }
    }
    
    private func fetchMovies(text: String) {
        let clean = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        self.dataManager?.requestMoviesTitle(input: clean) { resultBlock in
            switch resultBlock {
            case .success(let search):
                self.movies = search.movies
                self.handleMovies(result: search.movies)
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    private func fetchMovieDetail(index: Int) {
        guard let id = movies?[index].id else { return }
        self.dataManager?.requestMovieDetail(movieId: id) { resultBlock in
            switch resultBlock {
            case .success(let detail): self.handleDetail(result: detail)
            case .failure(let error): self.handleError(error: error)
            }
        }
    }
        
    private func handleMovies(result: [MovieEntity]) {
        self.presenter?.handle(.moviesSuccess(result))
    }
    
    private func handleDetail(result: MovieDetailEntity) {
        self.presenter?.handle(.detailSuccess(result))
    }
    
    private func handleError(error: Error) {
//        self.presenter?.handle(.error(error.localizedDescription))
    }
}
