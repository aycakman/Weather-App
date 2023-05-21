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
