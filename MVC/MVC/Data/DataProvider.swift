//
//  DataProvider.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class DataProvider {
    
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    let movies = [("tt1856101", "Blade Runner 2049"), ("tt0816692", "Interstellar"), ("tt2527336", "Star Wars: Episode VIII - The Last Jedi"), ("tt2802144", "Kingsman: The Secret Service"), ("tt3498820", "Captain America: Civil War")]
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3
        configuration.timeoutIntervalForResource = 3
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }
    
    var shouldFail = true
    func fetchMovie(withID id: String, completion: @escaping (Result<Movie>) -> Void) {
        let url: URL
        if shouldFail {
            url = URL(string: "https://www.omdbapi.com/?i=11\(id)&apikey=b861ddc9")!
            shouldFail = false
        } else {
            url = URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=b861ddc9")!
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                return completion(.failure(err))
            }
            
            if let data = data {
                do {
                    let movie = try self.decoder.decode(Movie.self, from: data)
                    return completion(.success(movie))
                } catch let err {
                    return completion(.failure(err))
                }
            } else {
                return completion(.failure(NSError.init(domain: "No Data", code: 0, userInfo: nil)))
            }
        }
        task.resume()
    }

    func nextMovie(currentID: String) -> (String, String) {
        guard let index = movies.index(where: { (movie) -> Bool in return movie.0 == currentID }) else { return movies.first! }
        if index + 1 == movies.count {
            return movies.first!
        }
        return movies[index+1]
    }
}
