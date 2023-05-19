//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Ayca Akman on 19.05.2023.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
