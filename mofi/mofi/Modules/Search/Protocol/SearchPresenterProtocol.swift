//
//  SearchPresenterProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import Foundation

enum SearchAction {
    case textEntered(text: String)
    case itemSelected(index: Int)
}

protocol SearchPresenterProtocol: class {
    
    var search: SearchViewProtocol? { get set }
//    var detail: SearchDetailViewProtocol? { get set }
    
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireframe: SearchWireframeProtocol? { get set }
    
    func perform(action: SearchAction)
}
