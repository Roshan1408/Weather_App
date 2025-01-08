//
//  WeatherModelConnectionWithController.swift
//  Weather_App
//
//  Created by Roshan on 07/01/25.
//

import Foundation

struct WeatherModelConnectionWithController
{
    let city: String
    let id: Int
    let temp: Double
    
    var weatherCondition: String
    {
        switch id
        {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
        }
    }
    var temperatureString:String
    {
        return String(format: "%.1f", temp)
    }
}
