//
//  CityCellView.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class CityWeatherCellView: UITableViewCell {

    @IBOutlet var cityTimeLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!

    func setData(_ cityWeather: Weather, index: Int) {
        cityTimeLabel.text = cityWeather.localTime
        cityNameLabel.text = cityWeather.name
        
        temperatureLabel.text = cityWeather.main.temp.formatTempString()
        temperatureLabel.accessibilityIdentifier = "temperatureLabel_\(index)"
        
        backgroundImage.image = UIImage(named: cityWeather.isDay ? "day" : "night")
    }
}
