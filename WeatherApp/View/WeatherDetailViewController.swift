//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/18/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var shortDescriptionLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var longDescriptionLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var feelLikeLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    
    var cityWeather: Weather? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = (cityWeather?.isDay ?? true) ? UIColor(red: 0/255, green: 197/255, blue: 246/255, alpha: 1) : UIColor(red: 45/255, green: 57/255, blue: 64/255, alpha: 1)

        cityNameLabel.text = cityWeather?.name
        shortDescriptionLabel.text = cityWeather?.weather[0].main
        iconImage.image = self.getWeatherIcon(icon: cityWeather?.weather[0].icon ?? "")
        temperatureLabel.text = cityWeather?.main.temp.formatTempString(isCelsius: true)
        
        longDescriptionLabel.text = "TODAY: \(cityWeather?.weather[0].description ?? ""). The high will be \(cityWeather?.main.tempMin.formatTempString(isCelsius: true) ?? "") and a low of \(cityWeather?.main.tempMin.formatTempString(isCelsius: true) ?? "")."
        
        sunriseLabel.text = cityWeather?.sys.localSunriseTime
        sunsetLabel.text = cityWeather?.sys.localSunsetTime
        
        feelLikeLabel.text = cityWeather?.main.feelsLike.formatTempString(isCelsius: true)
        humidityLabel.text = cityWeather?.main.humidity.formatHumidity()
        
        pressureLabel.text = cityWeather?.main.pressure.formatPressure()
        windLabel.text = self.getDirection(degrees: cityWeather?.wind.deg ?? -1, speed: cityWeather?.wind.speed ?? 0)
        
        visibilityLabel.text = cityWeather?.visibility.formatVisibility()
    }
    
    func getWeatherIcon(icon: String) -> UIImage {
        switch icon {
        case "01d": return UIImage(systemName: "sun.max")!
        case "01n": return UIImage(systemName: "moon")!
        case "02d": return UIImage(systemName: "cloud.sun")!
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
    
    func getDirection(degrees: Double, speed: Double) -> String {
        var direction = ""
        if (degrees != -1) {
            if(degrees > 23 && degrees <= 67){
                direction = "NE";
            } else if(degrees > 68 && degrees <= 112) {
                direction = "E";
            } else if(degrees > 113 && degrees <= 167) {
                direction = "SE";
            } else if(degrees > 168 && degrees <= 202) {
                direction = "S";
            } else if(degrees > 203 && degrees <= 247) {
                direction = "SW";
            } else if(degrees > 248 && degrees <= 293) {
                direction = "W";
            } else if(degrees > 294 && degrees <= 337) {
                direction = "NW";
            } else if(degrees >= 338 || degrees <= 22) {
                direction = "N";
            }
            return "\(direction) \(speed.formatWind())"
        }
        
        return speed.formatWind()
    }
}
