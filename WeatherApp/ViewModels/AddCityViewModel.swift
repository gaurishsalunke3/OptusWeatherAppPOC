//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation
import Combine

final class AddCityViewModel: ObservableObject {
    var cities = [City]()
    var filteredCities = [City]()

    @Published var searchText: String = ""
    
    private var cancellable = Set<AnyCancellable>()

    init() {
    }
    
    func getCitiesFromJSON(completion: @escaping(Result<[City], NetworkError>) -> Void) {
        let path = Bundle.main.path(forResource: Constants.cityJSON, ofType: "json")
        
        guard let urlString = path else {
            fatalError("Invalid path to local JSON.")
        }
        
        let url = URL(fileURLWithPath: urlString)
        
        WebService().getRequest(for: [City].self, with: url)
            .catch { _ in Just(self.cities) }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { cities in
                completion(.success(cities))
            })
            .store(in: &cancellable)
    }
    
    func searchCity(completion: @escaping(Result<[City], NetworkError>) -> Void) {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (receivedValue) in
                if self.searchText.isEmpty {
                    self.filteredCities = []
                } else {
                    self.filteredCities = self.cities.filter {
                        $0.name.range(of: self.searchText, options: [.caseInsensitive, .anchored]) != nil
                    }
                }
                completion(.success(self.filteredCities))
            }
            .store(in: &cancellable)
    }
}
