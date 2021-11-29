//
//  MovieTitleEntity.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation
    
struct MovieTitleEntity: Decodable {
    
    enum MediaType: String, Decodable {
        case movie, series, episode
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
    }
    
    var title: String
    var year: Int
    var id: String
    var type: MediaType
}
