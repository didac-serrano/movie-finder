//
//  SearchViewProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    func populate(_ state: SearchState)
}

enum SearchState {
    case success(entity: [MovieEntity])
    case error(error: String)
}
