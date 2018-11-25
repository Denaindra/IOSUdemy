//
//  ViewController.swift
//  Weather App
//
//  Created by gayan perera on 11/22/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , CLLocationManagerDelegate,CheckCityDeligate{
    
    
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var weaherIcon: UIImageView!
    @IBOutlet weak var citylabel: UILabel!
   
    private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    private let APP_ID = "168ff49f28afa80f5828077dd70d11ec"
    private let locationManager = CLLocationManager()
    private let weatherDataModel = WeatherDataModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func GetWeatherData(parameters:[String:String],url:String) {
        
        Alamofire.request(url,method:.get,parameters:parameters).responseJSON {
            responses in
            
            if responses.result.isSuccess
            {
                let value : JSON = JSON(responses.result.value!)
                self.UpdateWeatherData(value:value)
            }
            else
            {
                self.citylabel.text = "Internet issues"
            }
        }
        
    }
    
    func UpdateWeatherData(value:JSON){
        if let tempResult = value["main"]["temp"].double {
            weatherDataModel.tempreture = Int (tempResult - 273.15)
            weatherDataModel.city = value["name"].string
            weatherDataModel.condition = value["weather"][0]["id"].int
            weatherDataModel.weatherIconNam = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition!)
            UpdateWeatherInCurrentUI();
        }
        else {
            citylabel.text = "Weather is Unavailable"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation();
            let logitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let param:[String:String] = ["lat":latitude,"lon":logitude,"appid":APP_ID]
            GetWeatherData(parameters:param,url:WEATHER_URL)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        citylabel.text = "Unable retrive your location"
    }
    
    func UpdateWeatherInCurrentUI(){
        citylabel.text = weatherDataModel.city
        tempretureLabel.text = String(weatherDataModel.tempreture!) + "°"
        weaherIcon.image = UIImage(named: weatherDataModel.weatherIconNam!)
    }
    
    func UserEnterNewCity(city: String) {
        print(city)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UIViewControllerSegue"
        {
           let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self;
        }
    }
}


