//
//  FlowVC.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController, MovieViewControllerDelegate, FailedViewControllerDelegate {
    
    let provider: DataProviderProtocol
    var currentMovie: (String, String)!
    
    required init?(coder aDecoder: NSCoder) { fatalError("...") }
    
    init(provider: DataProviderProtocol) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(next: false)
    }
    
    func loadData(next: Bool) {
        transition(child: LoadingViewController())
        
        if next {
            currentMovie = provider.nextMovie(currentID: currentMovie.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.provider.fetchMovie(withID: self.currentMovie.0) { (result) in
                print(Thread.isMainThread ? "yes" : "no")
                switch result {
                case .success(let movie):
                    let movieVC = MovieViewController(movie: movie)
                    movieVC.delegate = self
                    self.transition(child: movieVC)
                case .failure(let error):
                    print(error.localizedDescription)
                    let failedVC = FailedViewController(message: "Failed to load: \(self.currentMovie.1)")
                    failedVC.delegate = self
                    self.transition(child: failedVC)
                }
            }
        }
    }
    
    // MARK: Protocols
    
    func movieViewControllerNextTapped(_ movieVC: MovieViewController) {
        loadData(next: true)
    }
    
    func failedViewControllerTryAgainTapped(_ failedVC: FailedViewController) {
        loadData(next: false)
    }
}
