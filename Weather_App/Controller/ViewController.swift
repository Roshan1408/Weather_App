//
//  ViewController.swift
//  Weather_App
//
//  Created by Roshan on 06/01/25.
//

import UIKit
import CoreLocation

class ViewController: UIViewController
{
    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var weatherManager=WeatherManager()
    var locationManager=CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate=self
        txtField.delegate=self
    }
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: -UITextFieldDelegate
extension ViewController: UITextFieldDelegate
{
    @IBAction func searchButton(_ sender: UIButton) {
        txtField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if textField.text != ""
        {
            return true
        }
        else{
            textField.placeholder="Please Enter City Name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let weatherCity=txtField.text
        {
            weatherManager.fecthWeatherUrl(weatherCity)
        }
        
        txtField.text=""
        txtField.placeholder="Search"
    }
}

//MARK: -Protocol_DataPass

extension ViewController: DataPass
{
    func dataPass(_ city: String, _ name: String, _ temp: String)
    {
        DispatchQueue.main.async
        {
            self.temperatureLabel.text=temp
            self.weatherImageView.image=UIImage(systemName: name)
            self.cityLabel.text=city
        }
    }
    
    func dataFail(error: any Error) {
        print(error)
    }
}

//MARK: -CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let lastLoc=locations.last
        {
            locationManager.stopUpdatingLocation()
            let lat=lastLoc.coordinate.latitude
            let lon=lastLoc.coordinate.longitude
            
            weatherManager.fetchWeatherUrl(latitude: lat, longitude: lon)
        }
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

