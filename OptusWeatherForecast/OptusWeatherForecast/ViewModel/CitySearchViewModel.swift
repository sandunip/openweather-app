//
//  CitySearchViewModel.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 13/2/22.
//

import Foundation

class CitySearchViewModel: NSObject {
    private var weatherService: WeatherServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var cities = CityResults()
    
    var citySearchCellViewModels = [CitySearchCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getCityInfo() {
        weatherService.getCities{ success, cities in
            if success {
                self.fetchData(cities: cities)
            } else {
                print("error")
            }
        }
    }
    
    func fetchData(cities: CityResults) {
        self.cities = cities
        var vms = [CitySearchCellViewModel]()
        for city in cities {
            vms.append(createCellModel(city: city))
        }
        citySearchCellViewModels = vms
    }
    
    func createCellModel(city: CitySearch) -> CitySearchCellViewModel {
        let id = city.id
        let name = city.name
        
        return CitySearchCellViewModel(id: id, name: name)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CitySearchCellViewModel {
        return citySearchCellViewModels[indexPath.row]
    }
}
