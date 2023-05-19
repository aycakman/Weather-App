//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Ayca Akman on 18.05.2023.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4a14f952b89bd72d7395a61a3c053f93&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
