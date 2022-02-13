//
//  ServiceManager.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation

class HttpRequestHelper {
    func GET(url: URL, params: [String: String], completion: @escaping (Bool, Cities) -> ()) {
        //guard let url = URL(string: url) else {return}
        print("url \(url)")
        URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) -> Void in
            guard let data = data, error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                print(json)
                let dataArray = json?["list"] as! [[String:Any]]
                var entryArray = [City]()

                for obj in dataArray {
                    let cityId = obj["id"] as! Int
                    let cityName = obj["name"] as! String
                    
                    let mainObj = obj["main"] as! [String:Any]
                    let temperature = mainObj["temp"] as! Double
                    let maxTemperature = mainObj["temp_max"] as! Double
                    let minTemperature = mainObj["temp_min"] as! Double
                    let humidity = mainObj["humidity"] as! Double
                    let pressure = mainObj["pressure"] as! Double
                    let feelslike = mainObj["feels_like"] as! Double
                    
                    let windObj = obj["wind"] as! [String:Any]
                    let windSpeed = windObj["speed"] as! Double
                    
                    let sysObj = obj["sys"] as! [String:Any]
                    let sunrise = sysObj["sunrise"] as! Double
                    let sunset = sysObj["sunset"] as! Double
                    
                    let weatherArray = obj["weather"] as! Array<Any>
                    let weatherObj = weatherArray[0] as! [String:Any]
                    let weatherMain = weatherObj["main"] as! String
                    let weatherDescription = weatherObj["description"] as! String
                    
                    let entry = City(id: cityId, name: cityName, temperature: String(temperature), minTemperature: String(minTemperature), maxTemperature: String(maxTemperature), feelsLike: String(feelslike), humidity: String(humidity), windSpeed: String(windSpeed), sunrise: String(sunrise), sunset: String(sunset), weatherMain: weatherMain, weatherDescription: weatherDescription, pressure: String(pressure))
                    entryArray.append(entry)
                }
                completion(true, entryArray)

            } catch {
                print("Something went wrong")
                completion(false, [City]())
            }
        }).resume()
    }
    
    func jsonDecoding () {
        
    }
}
