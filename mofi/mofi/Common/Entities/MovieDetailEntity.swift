//
//  MovieDetailEntity.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import Foundation

struct MovieDetailEntity: Decodable, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case picture = "Poster"
        case duration = "Runtime"
        case genre = "Genre"
        case release = "Released"
        case plot = "Plot"
        case id = "imdbID"
        case website = "Website"
    }
    
    var title: String
    var picture: String?
    var duration: String
    var genre: String
    var release: String
    var plot: String
    var id: String
    var website: String?
    
    func getSubtitle() -> String {
        return genre.capitalized + ". " + duration + ". Released in " + release + "."
    }
    
    func getPlot() -> String {
        return plot //hehe
    }
}
