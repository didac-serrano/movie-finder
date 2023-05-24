//
//  SearchPresenter.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import UIKit

class SearchPresenter: SearchPresenterProtocol, SearchInteractorOutputProtocol {
    
    var search: SearchViewProtocol?
    var detail: DetailViewProtocol?
    
    var wireframe: SearchWireframeProtocol?
    var interactor: SearchInteractorInputProtocol?
    
    func perform(action: SearchAction) {
        switch action {
        case .textEntered(let input):
            interactor?.perform(.requestMovies(text: input))
        case .itemSelected(let index):
            interactor?.perform(.requestMovieDetail(index: index))
        case .deleteSelected(let index):
            interactor?.perform(.deleteMovie(index: index))
        }
    }
    
    func handle(_ result: SearchInteractorResult) {
        switch result {
        case .moviesSuccess(let entity):
            DispatchQueue.main.async {
                self.search?.populate(.success(entity: entity))
            }
        case .detailSuccess(let entity):
            print(entity)
            DispatchQueue.main.async {
                self.createDetail(entity: entity)
            }
        case .error(let error):
            print(error)
//            self.search?.populate(.error(error: error))
        }
    }
    
    private func createDetail(entity: MovieDetailEntity) {
        let detail = DetailView()
        detail.presenter = self
        self.detail = detail
        wireframe?.navigate(to: .detail(detail))
        detail.populate(.success(entity: entity))
    }
}
