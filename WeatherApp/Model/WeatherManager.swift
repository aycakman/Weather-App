//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Ayca Akman on 18.05.2023.
//

import Foundation
import CoreLocation

//delegate pattern
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4a14f952b89bd72d7395a61a3c053f93&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if  error != nil {
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        //let weatherVC = WeatherViewController()
                        //weatherVC.didUpdateWeather(weatherModel: weather)
                        self.delegate?.didUpdateWeather(self, weatherModel: weather)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weatherModel = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            //print(weatherModel.conditionName)
            //print(weatherModel.temperatureString)
            return weatherModel
            
            
        }catch {
            //print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
   
}
