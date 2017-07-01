//
//  WeatherCellTableViewCell.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 28/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forcast: Forcast){
        lowTemp.text = "\(forcast.lowTemp)"
        highTemp.text = "\(forcast.highTemp)"
        weatherType.text = forcast.weatherType
        dayLabel.text = forcast.date
        weatherIcon.image = UIImage(named: forcast.weatherType)
    }

}
