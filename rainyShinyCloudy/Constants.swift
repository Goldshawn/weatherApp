//
//  Constants.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 26/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import Foundation

let baseURL = "http://api.openweathermap.org/data/2.5/weather?"

let latitude = "lat="
let longitude = "&lon="
let appId = "&appid="
let apiKey = "228c94b1552b4666b027657114b56259"

typealias downloadComplete = () -> ()

let currentURL = "\(baseURL)\(latitude)\(Location.sharedInstance.latitude!)\(longitude)\(Location.sharedInstance.longitude)\(appId)\(apiKey)"
let forcastURL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude)&appid=228c94b1552b4666b027657114b56259"
