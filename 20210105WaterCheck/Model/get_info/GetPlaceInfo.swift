

import CoreLocation

extension OutcomeViewController{
//    func setupLocationManager() {
//        locationManager = CLLocationManager()
//        // 位置情報取得許可ダイアログの表示
//        guard let locationManager = locationManager else { return }
//        locationManager.requestWhenInUseAuthorization()
//        // マネージャの設定
//        let status = CLLocationManager.authorizationStatus()
//        // ステータスごとの処理
//        if status == .authorizedWhenInUse {
//            locationManager.delegate = self
//            // 位置情報取得を開始
//            print("位置情報取得を開始")
//            locationManager.startUpdatingLocation()
//        }
//    }
//    //位置情報が更新されるたびに呼ばれるメソッド
//    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [ CLLocation ] ) {
//        let location = locations.first
//        let latitude = location?.coordinate.latitude
//        let longitude = location?.coordinate.longitude
//        // 位置情報を格納する
//        self.latitudeNow = String(latitude!)
//        self.longitudeNow = String(longitude!)
//        print("lat:", latitudeNow)
//        print("lot:", longitudeNow)
//        //表示更新
//        if let location = locations.first {
//            //逆ジオコーディング
//            self.geocoder.reverseGeocodeLocation( location, completionHandler: { ( placemarks, error ) in
//                if let placemark = placemarks?.first {
//                    //住所
//                    self.administrativeArea = placemark.administrativeArea == nil ? "" : placemark.administrativeArea!
//                    self.locality = placemark.locality == nil ? "" : placemark.locality!
//                    let subLocality = placemark.subLocality == nil ? "" : placemark.subLocality!
//                    let thoroughfare = placemark.thoroughfare == nil ? "" : placemark.thoroughfare!
//                    self.subThoroughfare = placemark.subThoroughfare == nil ? "" : placemark.subThoroughfare!
//                    self.placeName = !thoroughfare.contains( subLocality ) ? subLocality : thoroughfare
//                    print("administrativeArea:", self.administrativeArea)
//                    print("locality:", self.locality)
//                    print("placeName:", self.placeName)
//                    print("subThoroughfare:", self.subThoroughfare)
//                    self.addresText = self.administrativeArea + self.locality + self.placeName + self.subThoroughfare
//                    print("addres:", self.addresText)
//                }
//            })
//        }
//    }

}
