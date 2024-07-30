//
//  File.swift
//  weatherApp
//
//  Created by Mastery on 16.07.2024.
//

import Foundation
import UIKit

struct Response: Codable {
    var location: Location
    var current: Current
}

struct Response2: Codable {
    var forecast: Forecast?
}

struct Location: Codable {
    var name: String
}

struct Current: Codable {
    var temperatureInCelsius: Double
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case temperatureInCelsius = "temp_c"
        case condition
    }

    struct Condition: Codable {
        var text: String
        var icon: String
    }
}


struct Forecast: Codable {
    var forecastday:[ForecastDay]
    
struct ForecastDay: Codable {
        var date: String
        var day: Day
        
        struct Day: Codable{
            var averageTemperatureInCelsius: Double
            
            enum CodingKeys: String, CodingKey {
                case averageTemperatureInCelsius = "avgtemp_c"
            }
        }
    }
}
