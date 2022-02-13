//
//  APIClient.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation

protocol WeatherServiceProtocol {
    func getCityWeather(cities: String,completion: @escaping (_ success: Bool, _ results: Cities) -> ())
    func getCities(completion: @escaping (_ success: Bool, _ results: CityResults) -> ())
}

class WeatherService: WeatherServiceProtocol {
    func getCityWeather(cities: String, completion: @escaping (Bool, Cities) -> ()) {
        HttpRequestHelper().GET(url: WeatherInfoRouter.getWeatherInfo(cities, URLConstants.Api.APIKEY.APIKEY).url, params: ["": ""]) { success, cities in
            if success {
                do {
                    completion(true, cities)
                } catch {
                    completion(false, [City]())
                }
            } else {
                completion(false, [City]())
            }
        }
    }
    
    func getCities(completion: @escaping (Bool, CityResults) -> ()){
        if let path = Bundle.main.path(forResource: "current.city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
                var entryArray = [CitySearch]()
                for obj in jsonArray {
                    let cityId = obj["id"] as! Int
                    let cityName = obj["name"] as! String
                    let entry = CitySearch(id: cityId, name: cityName)
                    entryArray.append(entry)
                }
                completion(true, entryArray)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completion(false, [CitySearch]())
            }
        } else {
            print("Invalid filename/path.")
            completion(false, [CitySearch]())
        }
    }
}
