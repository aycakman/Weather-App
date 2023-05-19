//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ayca Akman on 17.05.2023.

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchtextField.delegate = self
    }
    
    func performRequest(urlString: String) {
        
        if let url  = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }

    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }catch {
            print(error)
        }
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchtextField.endEditing(true) // dismiss the keyboard
        print(searchtextField.text!)

    }
}



extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchtextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Type something here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchtextField.text {      
            weatherManager.fetchWeather(cityName: city)
        }
        searchtextField.text = ""
    }
}
