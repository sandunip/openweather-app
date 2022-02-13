//
//  UserDefaultsManager.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 13/2/22.
//

import Foundation

struct UserDefaultsKey {
    static let selectedCities = "selectedCities"
}

class UserDefaultsManager{
    
    static func set(value val:Any?, for key:String){
        guard let val = val else {return}
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getValue(forKey key:String) -> Any?{
        return UserDefaults.standard.value(forKey:key)
    }
    
    static func setSelectedCities(for cities:[Int:String]){
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: cities, requiringSecureCoding: false) as Data else { fatalError("Can't encode data") }
        set(value: data, for: UserDefaultsKey.selectedCities)
    }
    
    static func getSelectedCities() -> [Int:String]?{
        let value = UserDefaultsManager.getValue(forKey: UserDefaultsKey.selectedCities)
        let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value as? Data ?? Data()) as? [Int:String]
        return data
    }
}
