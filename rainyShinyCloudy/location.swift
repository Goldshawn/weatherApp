//
//  location.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 28/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init () {
        
    }
    var latitude: Double!
    var longitude: Double!
}
