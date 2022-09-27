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
        return getDuration() + genre.capitalized + ". " +  " Released in " + release + "."
    }
    
    func getDuration() -> String {
        let clean = duration.replacingOccurrences(of: "N/A", with: "")
        if clean == "" { return clean }
        else {
            return clean + ". "
        }
    }
    
    func getPlot() -> String {
        return plot //hehe
    }
}
