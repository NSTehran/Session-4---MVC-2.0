//
//  MovieVC.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit

protocol MovieViewControllerDelegate: class {
    func movieViewControllerNextTapped(_ movieVC: MovieViewController)
}

class MovieViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var ratedLabel: UILabel!
    @IBOutlet var runTimeLabel: UILabel!
    @IBOutlet var productionLabel: UILabel!
    
    @IBOutlet var webViewContainer: UIView!
    var webView: WebViewViewController?
    weak var delegate: MovieViewControllerDelegate?
    let movie: Movie
    
    required init?(coder aDecoder: NSCoder) { fatalError("...") }

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        titleLabel.text = movie.title
        yearLabel.text = "Year: " + movie.year
        ratedLabel.text = "Rated: " + movie.rated
        runTimeLabel.text = "Runtime: " + movie.runTime
        productionLabel.text = "Prod: " + movie.production
        transition(to: webViewContainer, duration: 0, child: WebViewViewController(urlString: movie.website))
    }
    
    @IBAction func nextAction(_ sender: Any) {
        delegate?.movieViewControllerNextTapped(self)
    }
}
