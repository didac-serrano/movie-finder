//
//  SearchAPIDataManager.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

final class SearchAPIDataManager: SearchAPIDataManagerProtocol {
    
    private let dataRetriever = URLDataRetriever()
    private var url = "http://www.omdbapi.com/?"
    private var apikey = "&apikey=ffe6baf4"
    
    //user types
    func requestMoviesTitle(input: String, resultBlock: @escaping APIDataManagerMovieResultBlock) {
        url = url + "s=" + input + apikey
        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieResult) in
            resultBlock(result)
        }
    }
    
    //user scrolls
    func requestMoviesPage(input: String, page: Int, resultBlock: @escaping APIDataManagerMovieResultBlock) {
        url = url + "s=" + input + "page=" + String(page) + apikey
        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieResult) in
            resultBlock(result)
        }
    }
    
    //user chooses one movie from the list
    func requestMovieDetail(movieId: String, resultBlock: @escaping APIDataManagerMovieDetailResultBlock) {
        url = url + "i=" + movieId + apikey
        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieDetailResult) in
            resultBlock(result)
        }
    }
}
