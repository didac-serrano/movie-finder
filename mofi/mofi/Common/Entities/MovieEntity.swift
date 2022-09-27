//
//  MovieEntity.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation
    
struct MovieEntity: Decodable, Encodable {
    
    enum MediaType: String, Decodable, Encodable {
        case movie, series, episode
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case picture = "Poster"
    }
    
    var title: String
    var year: String
    var id: String
    var type: MediaType
    var picture: String?
    
    func getInfo() -> String {
        return type.rawValue.capitalized + " from " + getYear()
    }
    
    //unconcluded series appear like "2022-" which looks ugly :S
    func getYear() -> String {
        return String(year.prefix(4))
    }
}
