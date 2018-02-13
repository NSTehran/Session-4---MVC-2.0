//
//  MovieViewController.swift
//  MVC
//
//  Created by Farzad Nazifi on 13.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit
import WebKit

class MovieViewController: UIViewController, WKNavigationDelegate {
    var currentMovie: (String, String)!
    var dataProvider: DataProvider!
    
    @IBOutlet var loadingView: UIView!
    @IBOutlet var webView: UIView!
    @IBOutlet var webViewLoadingView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var failedView: UIView!
    
    @IBOutlet var failedLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var ratedLabel: UILabel!
    @IBOutlet var runTimeLabel: UILabel!
    @IBOutlet var productionLabel: UILabel!
    
    @IBOutlet var wkView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wkView.navigationDelegate = self
        reload()
    }
    
    func reload() {
        self.loadingView.alpha = 1
        self.contentView.alpha = 0
        self.failedView.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.dataProvider.fetchMovie(withID: self.currentMovie.0) { (result) in
                switch result {
                case .success(let movie):
                    self.titleLabel.text = movie.title
                    self.yearLabel.text = "Year: " + movie.year
                    self.ratedLabel.text = "Rated: " + movie.rated
                    self.runTimeLabel.text = "Runtime: " + movie.runTime
                    self.productionLabel.text = "Prod: " + movie.production
                    if let url = URL(string: movie.website) {
                        self.wkView.load(URLRequest(url: url))
                    }
                    self.animateIn(viewToAnimate: self.contentView)
                case .failure:
                    self.failedLabel.text = "Failed to load: \(self.currentMovie.1)"
                    self.animateIn(viewToAnimate: self.failedView)
                }
            }
        }
    }
    
    func animateIn(viewToAnimate: UIView) {
        let rootViews = [loadingView, contentView, failedView]
        UIView.animate(withDuration: 0.25) {
            rootViews.forEach({ (subView) in
                if subView == viewToAnimate {
                    subView?.alpha = 1
                }else{
                    subView?.alpha = 0
                }
            })
        }
    }

    @IBAction func failedTryAgainAction(_ sender: Any) {
        reload()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        currentMovie = dataProvider.nextMovie(currentID: currentMovie.0)
        reload()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webViewLoadingView.isHidden = false
        webView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewLoadingView.isHidden = true
        webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webViewLoadingView.isHidden = true
        webView.isHidden = true
    }
}

