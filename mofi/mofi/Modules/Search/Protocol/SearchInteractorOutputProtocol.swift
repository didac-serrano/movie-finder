//
//  SearchInteractorOutputProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import Foundation

enum SearchInteractorResult {
    case moviesSuccess(_ entity: [MovieEntity])
    case detailSuccess(_ entity: MovieDetailEntity)
    case error(_ error: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    
    func handle(_ result: SearchInteractorResult)
}
