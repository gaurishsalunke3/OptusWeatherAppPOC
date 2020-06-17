//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTableView: UITableView!
    
    var weatherVM = WeatherViewModel()
    var cities = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Your Weather App"
                
        self.loadData()
    }
    
    private func loadData() {
        self.weatherVM.getCurrentWeatherForMultipleCities { [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                self?.cityTableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCellView
        
        let cityWeather = self.cities[indexPath.row]
        cell.setData(cityWeather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

