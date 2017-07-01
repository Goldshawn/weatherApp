//
//  currentWeather.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 26/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName : String!
    private var _date : String!
    private var _weatherType : String!
    private var _currentTemp : Double!
    
    var cityName : String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.00
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails (completed: @escaping downloadComplete) {
        //Alamofire Download
        self._cityName = "Mother"
        self._currentTemp = 32.3
        self._weatherType = "Rain"
        let currentWeatherUrl = URL(string: currentURL)!
        Alamofire.request(currentWeatherUrl).responseJSON{ response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>]{
                    
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any>{
                    
                    if let currentTemp =  main["temp"] as? Double{
                        let celciusTemp = currentTemp - 273.15
                        self._currentTemp = celciusTemp
                        print(self._currentTemp)
                    }
                }
                completed()
            }
        }
    }
}

