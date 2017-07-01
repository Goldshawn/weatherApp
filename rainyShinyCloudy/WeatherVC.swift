//
//  WeatherVC.swift
//  rainyShinyCloudy
//
//  Created by Shalom Owolabi on 24/06/2017.
//  Copyright © 2017 SpotPin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentLocLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var currentWeather:  CurrentWeather!
    var forcast: Forcast!
    
    var forcasts = [Forcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }
    
    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather = CurrentWeather()
            currentWeather.downloadWeatherDetails {
                self.downloadForcastData {
                    self.updateMainUI()
                }
                
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func downloadForcastData(completed: @escaping downloadComplete){
        let forcastUrl = URL(string: forcastURL)!
        
        Alamofire.request(forcastUrl).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any>{
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                    for obj in list{
                        let forcast = Forcast(weatherDict: obj)
                        self.forcasts.append(forcast)
                        print(obj)
                        
                    }
                    self.forcasts.remove(at: 0)
                    self.weatherTableView.reloadData()
                }
            }
            
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(forcasts.count)
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = weatherTableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forcast = forcasts[indexPath.row]
            
            cell.configureCell(forcast: forcast)
            return cell
        }
        else{
            return WeatherCell()
        }
    
    }
    
    func updateMainUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentLocLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }


}

