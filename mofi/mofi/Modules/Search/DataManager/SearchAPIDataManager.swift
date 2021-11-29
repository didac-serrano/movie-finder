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
    
    //user has feedback while typing
    func requestMoviesTitle(input: String, resultBlock: @escaping APIDataManagerMovieTitleResultBlock) {
        url = url + "s=" + input + apikey
        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieTitleResult) in
            resultBlock(result)
        }
    }
    
    //user chooses one suggestion from the list
    func requestMoviesComplete(input: String, resultBlock: @escaping APIDataManagerMovieCompleteResultBlock) {
        url = url + "s=" + input + apikey
        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieCompleteResult) in
            resultBlock(result)
        }
    }
    
    //user chooses one movie from the list
//    func requestMovieDetail(movieId: String, resultBlock: @escaping APIDataManagerMovieDetailResultBlock) {
//        url = url + "i=" + movieId + apikey
//        self.dataRetriever.retrieve(url: url) { (result: APIDataManagerMovieDetailResult) in
//            resultBlock(result)
//        }
//    }
    
}
