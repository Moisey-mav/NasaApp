//
//  RoverSettings.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import Foundation

final class RoverSettings {
    
    private enum SettingsKeys: String {
        case roverName
    }
    
    static var roverName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.roverName.rawValue)
        } set {
            let defolts = UserDefaults.standard
            let key = SettingsKeys.roverName.rawValue
            if let name = newValue {
                print("value: \(name) was added to key \(key)")
                defolts.set(name, forKey: key)
            }
        }
    }
    
}
