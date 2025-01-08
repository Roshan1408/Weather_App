//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Roshan on 06/01/25.
//

import Foundation
import UIKit
import CoreLocation


protocol DataPass
{
    func dataPass(_ city: String,_ name: String,_ temp: String )
    func dataFail(error: Error)
}

struct WeatherManager
{
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?appid=7d777f010144ab86975255e987edd841&units=metric&"
    var delegate:DataPass!

    func fecthWeatherUrl(_ cityName: String)
    {
        let url=weatherUrl+"q=\(cityName)"
        performRequest(with: url)
    }
    func fetchWeatherUrl(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let url=weatherUrl+"lat=\(latitude)&lon=\(longitude)"
        performRequest(with: url)
    }
    
    func performRequest(with url: String)
    {
        //1. Create URL
       if  let url = URL(string: url)
        {
        //2. Create URL Session
        let session=URLSession(configuration: .default)
        
        //3. Give URLSession task
        let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        
        //4. start task
           task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?)
    {
            if error != nil{
                delegate.dataFail(error: error!)
                return
            }
            
        if let safeData=data
            {
            parseJSONDecode(safeData)
            
        }
    }
    
    func parseJSONDecode(_ weatherdata: Data)
    {
        let decoder=JSONDecoder()
        do
        {
            let decodedData=try decoder.decode(JSONWeatherData.self, from: weatherdata)
            
            let name=decodedData.name
            let id=decodedData.weather[0].id
            let temp=decodedData.main.temp
            
            let weather=WeatherModelConnectionWithController(city: name, id: id, temp: temp)
            let weatherCondtionName=weather.weatherCondition
            let temperaturestring=weather.temperatureString
            delegate.dataPass(name, weatherCondtionName, temperaturestring)
        }
        catch
        {
            delegate.dataFail(error: error)
        }
    }
}
