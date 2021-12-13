//
//  SearchInteractorInputProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import Foundation

enum SearchJob {
    case requestMovies(text: String)
    case requestPage(index: Int)
    case requestMovieDetail(index: Int)
}

protocol SearchInteractorInputProtocol: class {
    
    var selectedMovie: MovieEntity? { get set }

    var presenter: SearchInteractorOutputProtocol? { get set }
    var dataManager: SearchAPIDataManagerProtocol? { get set }
    
    func perform(_ job: SearchJob)
}
