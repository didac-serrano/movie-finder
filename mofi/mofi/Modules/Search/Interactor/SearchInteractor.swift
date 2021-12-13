//
//  SearchInteractor.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    
    var selectedMovie: MovieEntity?
    private var model: SearchEntity?
    private let itemsPerPage = 10
    private let boundaries = 4
    private var currentPage: Int
    private var input: String?

    weak var presenter: SearchInteractorOutputProtocol?
    var dataManager: SearchAPIDataManagerProtocol?
    
    init() {
        self.dataManager = SearchAPIDataManager()
        currentPage = 0
    }
    
    func perform(_ job: SearchJob) {
        switch job {
        case .requestMovies(let text): fetchMovies(text: text)
        case .requestPage(let index): scrollTo(index: index)
        case .requestMovieDetail(let index): fetchMovieDetail(index: index)
        }
    }
    
    private func fetchMovies(text: String) {
        self.currentPage = 1
        let clean = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        self.input = clean
        self.dataManager?.requestMoviesTitle(input: clean) { resultBlock in
            switch resultBlock {
            case .success(let search):
                self.model = search
                self.handleMovies(result: search.movies)
            case .failure(let error):
                self.currentPage = 0
                self.handleError(error: error)
            }
        }
    }
    
    private func scrollTo(index: Int) {
        guard let input = self.input else { return }
        if (currentPage * itemsPerPage) - (itemsPerPage / boundaries) <= index {
            self.currentPage += 1
            self.dataManager?.requestMoviesPage(input: input, page: currentPage) { resultBlock in
                switch resultBlock {
                case .success(let new):
                    let merged = self.merge(self.model, with: new)
                    self.model = merged
                    self.handleMovies(result: merged.movies)
                case .failure(let error):
                    self.currentPage -= 1
                    self.handleError(error: error)
                }
            }
        }
    }
    
    private func merge(_ firstModel: SearchEntity?, with secondModel: SearchEntity) -> SearchEntity {
        guard let firstModel = firstModel else {
            return secondModel
        }
        var newModel = firstModel
        newModel.movies.append(contentsOf: secondModel.movies)
        return newModel
    }
    
    private func fetchMovieDetail(index: Int) {
        guard let id = model?.movies[index].id else { return }
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
//        self.presenter?.handle(.detailSuccess(result))
    }
    
    private func handleError(error: Error) {
//        self.presenter?.handle(.error(error.localizedDescription))
    }
}
