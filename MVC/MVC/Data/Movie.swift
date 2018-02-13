//
//  Movie.swift
//  MVC 2.0
//
//  Created by Farzad Nazifi on 06.02.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case runTime = "Runtime"
        case production = "Production"
        case website = "Website"
    }
    
    let title: String
    let year: String
    let rated: String
    let runTime: String
    let production: String
    let website: String
}
