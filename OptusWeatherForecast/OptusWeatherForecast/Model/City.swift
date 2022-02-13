//
//  City.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation

typealias Cities = [City]
typealias CityResults = [CitySearch]

// MARK: - City
//struct City: Codable {
//    var id: String
//    var name: String
//    var tempurature: String
//    var humidity: String
//    var windSpeed: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "name"
//        case tempurature = "tempurature"
//        case humidity = "humidity"
//        case windSpeed = "windSpeed"
//    }
//}

class City {
    var id: Int
    var name: String
    var temperature: String
    var minTemperature: String
    var maxTemperature: String
    var feelsLike: String
    var humidity: String
    var windSpeed: String
    var sunrise: String
    var sunset: String
    var weatherMain: String
    var weatherDescription: String
    var pressure: String
    
    init(id:Int,name:String,temperature:String, minTemperature:String, maxTemperature:String, feelsLike:String, humidity:String, windSpeed:String, sunrise:String, sunset:String, weatherMain:String, weatherDescription:String, pressure:String) {
        self.id = id
        self.name = name
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.sunrise = sunrise
        self.sunset = sunset
        self.weatherMain = weatherMain
        self.weatherDescription = weatherDescription
        self.pressure = pressure
    }
}

class CitySearch {
    var id: Int
    var name: String
    
    init(id:Int,name:String) {
        self.id = id
        self.name = name
    }
}
