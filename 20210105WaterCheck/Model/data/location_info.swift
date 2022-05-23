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
    
    func reverse_geo_coding(locations:[ CLLocation ])
    {
        let geocoder = CLGeocoder()
        if let location = locations.first {
            geocoder.reverseGeocodeLocation( location, completionHandler: { ( placemarks, error ) in
                if let placemark = placemarks?.first {
                    self.admin = placemark.administrativeArea == nil ? "" : placemark.administrativeArea!
                    self.locality = placemark.locality == nil ? "" : placemark.locality!
                    let subLocality = placemark.subLocality == nil ? "" : placemark.subLocality!
                    let thoroughfare = placemark.thoroughfare == nil ? "" : placemark.thoroughfare!
                    self.subthr = placemark.subThoroughfare == nil ? "" : placemark.subThoroughfare!
                    self.place_name = !thoroughfare.contains( subLocality ) ? subLocality : thoroughfare
                    self.address = self.admin! + self.locality! + self.place_name! + self.subthr!
                    print(self.address as Any)
                }
            })
        }
    }
}
