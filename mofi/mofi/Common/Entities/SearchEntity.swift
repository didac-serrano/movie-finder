//
//  SearchEntity.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 08/12/2021.
//

import Foundation

struct SearchEntity: Decodable, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
    
    var movies: [MovieEntity]   // No need to be optional, we get parsing error if no match
    var totalResults: String    // TBD cast to Int
    var response: String        // TBD cast to Bool
}
