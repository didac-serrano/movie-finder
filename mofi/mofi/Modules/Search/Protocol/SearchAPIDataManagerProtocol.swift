//
//  SearchAPIDataManagerProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

typealias APIDataManagerMovieResult = (Result<SearchEntity, Error>)
typealias APIDataManagerMovieDetailResult = (Result<MovieDetailEntity, Error>)

typealias APIDataManagerMovieResultBlock = (Result<SearchEntity, Error>) -> Void
typealias APIDataManagerMovieDetailResultBlock = (Result<MovieDetailEntity, Error>) -> Void

protocol SearchAPIDataManagerProtocol: AnyObject {
    
    func requestMoviesTitle(input: String, resultBlock: @escaping APIDataManagerMovieResultBlock)
    func requestMovieDetail(movieId: String, resultBlock: @escaping APIDataManagerMovieDetailResultBlock)
}
