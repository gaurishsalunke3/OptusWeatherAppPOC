//
//  Extension.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    func formatDate(timezoneOffset: Int) -> String {
        let time = Date(timeIntervalSince1970: Double(self))
        let timezone = TimeZone(secondsFromGMT: timezoneOffset)

        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = timezone
        
        return formatter.string(from: time)
    }
    
    func formatHumidity() -> String {
        return String(format: "%d%%", self)
    }

    func formatPressure() -> String {
        return String(format: "%d hPa", self)
    }
    
    func formatVisibility() -> String {
        let visibility = Double(self)/1000
        return String(format: "%.0f km%@", visibility, visibility > 1 ? "s" : "")
    }
}

extension Double {
    func formatTempString(isCelsius: Bool) -> String {
        if isCelsius {
            return String(format: "%.0f%@", self, "\u{00B0}")
        } else {
            let fah = (self * (9/5)) + 32
            return String(format: "%.0f%@", fah, "\u{00B0}")
        }
    }
    
    func formatWind() -> String {
        return String(format: "%d kph", self)
    }
}

extension String {
    // This method converts the first letter to CAPS.
    // Used to fix the cityWeather?.weather[0].description property,
    // which is returned as all lower case in the api response.
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid URL.")
        }
        
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return component.url
    }
}

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
