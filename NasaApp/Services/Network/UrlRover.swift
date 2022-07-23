//
//  UrlRover.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 23.07.2022.
//

import Foundation

class UrlRover {
    
    private func creatingURL(name: String,apiKey: String,earthDate: String) -> String {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(name)/photos?earth_date=\(earthDate)&api_key=\(apiKey)"
        return urlString
    }
    
    func setupData(name: String?, apiKey: String?, earthDate: String?) -> String {
        guard let roverName = name else { return "Error" }
        guard let apiKey = apiKey else { return "Error" }
        guard let earthDate = earthDate  else { return "Error" }
        let url = creatingURL(name: roverName, apiKey: apiKey, earthDate: earthDate)
        return url
    }
   
}
