//
//  SearchAPIDataManagerProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

typealias APIDataManagerMovieTitleResult = (Result<[MovieTitleEntity], Error>)
typealias APIDataManagerMovieCompleteResult = (Result<[MovieCompleteEntity], Error>)
//typealias APIDataManagerMovieDetailResult = (Result<MovieDetailEntity, Error>)

typealias APIDataManagerMovieTitleResultBlock = (Result<[MovieTitleEntity], Error>) -> Void
typealias APIDataManagerMovieCompleteResultBlock = (Result<[MovieCompleteEntity], Error>) -> Void
//typealias APIDataManagerMovieDetailResultBlock = (Result<MovieDetailEntity, Error>) -> Void

protocol SearchAPIDataManagerProtocol: class {
    
    func requestMoviesTitle(input: String, resultBlock: @escaping APIDataManagerMovieTitleResultBlock)
    func requestMoviesComplete(input: String, resultBlock: @escaping APIDataManagerMovieCompleteResultBlock)
//    func requestMoviesDetail(input: String, resultBlock: @escaping APIDataManagerMovieDetailResultBlock)
}
