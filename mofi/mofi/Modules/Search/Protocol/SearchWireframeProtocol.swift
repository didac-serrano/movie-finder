//
//  SearchWireframeProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import UIKit

enum SearchPage {
    case search
    case detail(_ view: DetailView)
}

protocol SearchWireframeProtocol: AnyObject {
    
    var search: UIViewController! { get set }
    var detail: UIViewController? { get set }
    
    var presenter: SearchPresenter? { get set }
    
    func navigate(to page: SearchPage)
}
