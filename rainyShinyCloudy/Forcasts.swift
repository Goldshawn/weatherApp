//
//  Forcasts.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 27/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit
import Alamofire

class Forcast {
    
    private var _date:String!
    private var _weatherType:String!
    private var _highTemp:String!
    private var _lowTemp:String!
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, Any>) {
        if let main = weatherDict["main"] as? Dictionary<String, Any>{
            if let temp_min = main["temp_min"] as? Int{
                let celciusTemp = temp_min - 273
                self._lowTemp = "\(celciusTemp)°"
            }
            if let temp_max = main["temp_max"] as? Int{
                let celciusTemp = temp_max - 273
                self._highTemp = "\(celciusTemp)°"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "EEEE"
            dateformatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
