//
//  location_info.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import Foundation
import UIKit
import CoreLocation

class location_info
{
    var address:String?
    var lat:String?
    var lot:String?
    //都道府県
    var admin:String?
    //~市~区
    var locality:String?
    //~丁目
    var place_name:String?
    //~番地
    var subthr:String?
    
    var locationManager: CLLocationManager!
    func setupLocationManager()
    {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse ||  status == .authorizedAlways
        {
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.first
        _ = location?.coordinate.latitude
        _ = location?.coordinate.longitude
    }
    
}
