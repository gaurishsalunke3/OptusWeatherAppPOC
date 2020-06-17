//
//  City.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

struct City: Decodable, Identifiable {
    let id: Int
    let name, country: String
    
    var place: String {
        return "\(name), \(country)"
    }
}
