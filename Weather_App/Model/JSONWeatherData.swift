//
//  JSONWeatherData.swift
//  Weather_App
//
//  Created by Roshan on 07/01/25.
//

import Foundation
import UIKit

struct JSONWeatherData: Codable
{
    let name:String
    let weather: [Weather]
    let main:Main
    
}
struct Weather: Codable
{
    let id:Int
}
struct Main: Codable
{
    let temp:Double
}
