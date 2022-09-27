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
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var plot: UILabel!
    
    //No additional init needed
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    func populate(_ state: DetailState) {
        switch state {
        case .success(let movie):
            picture?.backgroundColor = .black
            if let url = URL(string: movie.picture!) {
                picture?.load.request(with: url)
            }
            name?.text = movie.title
            subtitle?.text = movie.getSubtitle()
            plot?.text = movie.getPlot()
//            here
        case .error(let error):
            print(error) //TBD
        }
    }
}
