//
//  Constants.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

struct Constants {
    static let weatherAPIKey = "5d3b73da5d4a73d304454cac4cbd20ef"
    static let kSavedCityIdArray = "savedCityIdArray"
    static let kMeasuringUnit = "measuringUnit"

    struct Cells {
        static let cityCell = "CityCell"
    }
    
    struct API {
        static let unit = UserDefaults.standard.string(forKey: kMeasuringUnit)
        
        static let getMutipleCityCurrentWeatherBaseURL = "https://api.openweathermap.org/data/2.5/group?"
        
        static let getCityCurrentWeatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?"
        
        static let weatherIconURL = "http://openweathermap.org/img/wn/"
    }
}
