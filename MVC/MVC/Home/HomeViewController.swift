//
//  HomeViewController.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    private let dataProvider = DataProvider()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataProvider.movies[indexPath.row].1
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovie" {
            if let movieVC = segue.destination as? MovieViewController {
                movieVC.currentMovie = dataProvider.movies[tableView.indexPathForSelectedRow!.last!]
                movieVC.dataProvider = dataProvider
            }
        }
    }
}

