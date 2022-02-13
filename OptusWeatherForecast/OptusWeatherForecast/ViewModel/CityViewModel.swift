//
//  CityViewModel.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation
import NVActivityIndicatorView

class CityViewModel: NSObject {
    private var weatherService: WeatherServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var cities = Cities()
    
    var cityCellViewModels = [CityCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getCityInfo() {
        let selectedCities = UserDefaultsManager.getSelectedCities()
        let citiIds = Array(selectedCities!.keys).map { String($0) }
        let citiIdString = citiIds.joined(separator: ",")
        weatherService.getCityWeather(cities: citiIdString) { success, cities in
            if success {
                self.fetchData(cities: cities)
            } else {
                print("error")
            }
        }
    }
    
    func fetchData(cities: Cities) {
        self.cities = cities // Cache
        var vms = [CityCellViewModel]()
        for city in cities {
            vms.append(createCellModel(city: city))
        }
        cityCellViewModels = vms
    }
    
    func createCellModel(city: City) -> CityCellViewModel {
        let id = city.id
        let name = city.name
        let temperature = city.temperature
        let humidity = city.humidity
        let windSpeed = city.windSpeed
        
        return CityCellViewModel(id: id, name: name, temperature: temperature, humidity: humidity, windSpeed: windSpeed)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CityCellViewModel {
        return cityCellViewModels[indexPath.row]
    }
}
