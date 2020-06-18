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
    static let cityJSON = "current.city.list"
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
    
    struct WeatherIcons {
        func getWeatherIcon(icon: String) -> UIImage {
            switch icon {
            case "01d": return UIImage(systemName: "sun.max")!
            case "01n": return UIImage(systemName: "moon")!
            case "02d": return UIImage(systemName: "cloud.sun.max")!
            case "02n": return UIImage(systemName: "cloud.moon")!
            case "03d": return UIImage(systemName: "cloud")!
            case "03n": return UIImage(systemName: "cloud")!
            case "04d": return UIImage(systemName: "smoke")!
            case "04n": return UIImage(systemName: "smoke")!
            case "09d": return UIImage(systemName: "cloud.rain")!
            case "09n": return UIImage(systemName: "cloud.rain")!
            case "10d": return UIImage(systemName: "cloud.sun.rain")!
            case "10n": return UIImage(systemName: "cloud.moon.rain")!
            case "11d": return UIImage(systemName: "cloud.bolt")!
            case "11n": return UIImage(systemName: "cloud.bolt")!
            case "13d": return UIImage(systemName: "snow")!
            case "13n": return UIImage(systemName: "snow")!
            case "50d": return UIImage(systemName: "wind")!
            case "50n": return UIImage(systemName: "wind")!
                
            default: return UIImage(systemName: "sun.max")!
            }
        }
    }
}
