//
//  WebViewVC.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: WKWebView!

    var urlString: String!
    
    required init?(coder aDecoder: NSCoder) { fatalError("...") }
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        webView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.isHidden = true
        webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.isHidden = true
        webView.isHidden = true
    }
}
