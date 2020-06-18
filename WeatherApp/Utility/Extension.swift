//
//  Extension.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

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

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid URL.")
        }
        
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return component.url
    }
}
