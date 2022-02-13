//
//  CityService.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 13/2/22.
//

import Foundation

enum WeatherInfoRouter{
    case getWeatherInfo(String,String)
    
    var url:URL{
        switch self {
        case .getWeatherInfo(let cities,let appId):
            return URL(string: String(format: URLConstants.Api.Path.entries, cities,appId))!
        }
    }
}
