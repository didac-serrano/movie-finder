//
//  DetailView.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 26/9/22.
//

import UIKit

class DetailView: UIViewController, DetailViewProtocol {

    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    private var info: MovieDetailEntity?
    
    //No additional init needed
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    func populate(_ state: DetailState) {
        switch state {
        case .success(let entity):
            self.info = entity
//            self.tableView.reloadData()
//            here
        case .error(let error):
            print(error) //TBD
        }
    }
}
