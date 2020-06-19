//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation
import Combine

final class WeatherViewModel {
    var citiesWeather: [Weather]?

    private var cancellable = Set<AnyCancellable>()

    init() {
    }
    
    func getCurrentWeatherForMultipleCities(completion: @escaping(Result<[Weather], NetworkError>) -> Void) {
        let unit = "metric"
        
        let defaults = UserDefaults.standard
        let citiesArray = defaults.object(forKey: Constants.kSavedCityIdArray) as! [Int]
        
        if citiesArray.count > 0 {
            let citiesId = self.getCitiesString(array: citiesArray)

            let query = ["appid": "\(Constants.weatherAPIKey)", "units": "\(unit)", "id": "\(citiesId)"]
            
            guard let url = URL(string: Constants.API.getMutipleCityCurrentWeatherBaseURL)?.withQueries(query) else {
                fatalError("Invalid URL.")
            }
            
            WebService().getRequest(for: WeatherReponse.self, with: url)
                .map { $0.list }
                .catch { _ in Just(self.citiesWeather)}
                .receive(on: RunLoop.main)
                .sink(receiveValue: { cities in
                    completion(.success(cities!))
                })
                .store(in: &cancellable)
        }
    }
    
    func getCitiesString(array:[Int]) -> String {
        let stringArray = array.map { String($0) }
        return stringArray.joined(separator: ",")
    }
    
    func deg_fah() -> String {
        return String(format: "%@ C/ %@ F", "\u{00B0}", "\u{00B0}")
    }

}
