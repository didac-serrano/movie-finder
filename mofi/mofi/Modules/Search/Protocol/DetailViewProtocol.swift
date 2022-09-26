//
//  DetailViewProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 26/9/22.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    func populate(_ state: DetailState)
}

enum DetailState {
    case success(entity: MovieDetailEntity)
    case error(error: String)
}
