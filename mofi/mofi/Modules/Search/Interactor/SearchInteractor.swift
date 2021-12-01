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
        case .storeSelectedMovie(let index): storeMovie(index: index)
        case .requestMovieDetail: fetchMovieDetail()
        }
    }
    
    private func fetchMovies(text: String) {
        let clean = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        self.dataManager?.requestMoviesTitle(input: clean) { resultBlock in
            switch resultBlock {
            case .success(let movies):
                self.movies = movies
                self.handleMovies(result: movies)
            case .failure(let error): self.handleError(error: error)
            }
        }
    }
    
    private func fetchMovieDetail() {
        guard let id = selectedMovie?.id else { return }
        self.dataManager?.requestMovieDetail(movieId: id) { resultBlock in
            switch resultBlock {
            case .success(let detail): self.handleDetail(result: detail)
            case .failure(let error): self.handleError(error: error)
            }
        }
    }
    
    private func storeMovie(index: Int) {
        guard let movie = movies?[index] else { return }
        self.selectedMovie = movie
    }
        
    private func handleMovies(result: [MovieEntity]) {
//        self.presenter?.handle(.moviesSuccess(result))
    }
    
    private func handleDetail(result: MovieDetailEntity) {
//        self.presenter?.handle(.detailSuccess(result))
    }
    
    private func handleError(error: Error) {
//        self.presenter?.handle(.error(error.localizedDescription))
    }
}
