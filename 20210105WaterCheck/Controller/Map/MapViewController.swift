//
//  MapViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate
{
    
    @IBOutlet weak var map_view: MKMapView!
    @IBOutlet weak var segment_view: UISegmentedControl!
    @IBOutlet weak var back_button: UIButton!
    @IBOutlet weak var ahead_button: UIButton!
    @IBOutlet weak var date_tf: UITextField!
    @IBOutlet weak var serch_tf: UITextField!
    
    var contents = [Contents]()
    var filterd_contents = [Contents]()
    var locManager: CLLocationManager!
    
    var pH_to_rgb = pH_to_RGB()
    var week_ca = WeekGraph()
    var month_ca = MonthGraph()
    var year_ca = YearGraph()
    var day_ca = DayGraph()
    var ca_info = [String:Int]()
    var seg_index = Int()
    var search_text = ""
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        seg_index = 0
        set_view()
        serch_tf.delegate = self
        map_view.delegate = self
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            switch CLLocationManager.authorizationStatus()
            {
            case .authorizedWhenInUse:
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }
        initMap()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        if let searchKey = textField.text
        {
        print(searchKey)
        let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                if let unwrapPlacemarks = placemarks
                {
                    if let firstPlacemark = unwrapPlacemarks.first
                    {
                        if let location = firstPlacemark.location
                        {
                            let targetCoordinate = location.coordinate
                            self.map_view.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                            textField.text = ""
                        }
                    }
                }
            })
        }
        return (true)
    }
    
    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        segment_view.backgroundColor = .white
        segment_view.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        serch_tf.frame = CGRect(x: v_w * 10, y: v_h * 11, width: v_w * 80, height: v_h * 6)
        map_view.frame = CGRect(x: 0, y: v_h * 19, width: v_w * 100, height: v_h * 52)
        segment_view.frame = CGRect(x: v_w * 15, y: v_h * 74, width: v_w * 70, height: v_h * 5)
        date_tf.frame = CGRect(x: v_w * 23, y: v_h * 81, width: v_w * 54, height: v_h * 7)
        back_button.frame = CGRect(x: v_w * 2, y: v_h * 81, width: v_w * 19, height: v_h * 7)
        ahead_button.frame = CGRect(x: v_w * 79, y: v_h * 81, width: v_w * 19, height: v_h * 7)
        back_button.imageView?.contentMode = .scaleAspectFit
        back_button.contentHorizontalAlignment = .fill
        back_button.contentVerticalAlignment = .fill
        ahead_button.imageView?.contentMode = .scaleAspectFit
        ahead_button.contentHorizontalAlignment = .fill
        ahead_button.contentVerticalAlignment = .fill
        date_tf.layer.borderColor = UIColor.black.cgColor
        date_tf.layer.borderWidth = 1.0
        date_tf.adjustsFontSizeToFitWidth = true
        serch_tf.layer.borderColor = UIColor.black.cgColor
        serch_tf.layer.borderWidth = 1.0
        serch_tf.adjustsFontSizeToFitWidth = true
        serch_tf.attributedPlaceholder = NSAttributedString(string: "検索", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        seg_index = 0
        segment_view.selectedSegmentIndex = 0
        ca_info = day_ca.First()
        date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)"
        fetch_data()
        for content in contents
        {
            print("~~~~")
            print(content.minute!)
        }
        filter_content()
        draw_circle_pin()
    }
    
    func filter_content()
    {
        switch seg_index {
        case 0:
            filterd_contents = self.contents.filter
            {(contents:Contents)-> Bool in return
                contents.year == String(ca_info["Fyear"]!) && contents.month == String(ca_info["fM"]!) &&
                contents.day == String(ca_info["fD"]!)
            }
        case 1:
            if ca_info["fM"] != ca_info["lM"]
            {
                if (ca_info["Fyear"] != ca_info["Lyear"])
                {
                    filterd_contents = self.contents.filter
                    { (contents) -> Bool in return
                        (contents.year == String(ca_info["Fyear"]!) || contents.year == String(ca_info["Lyear"]!)) &&
                        ((contents.month == "12" && Int(contents.day!)! >= ca_info["fD"]!) || (contents.month == "1" && Int(contents.day!)! <= ca_info["lD"]!))
                    }
                }
                else
                {
                    filterd_contents = self.contents.filter
                    { (contents) -> Bool in return
                        contents.year == String(ca_info["Fyear"]!) &&
                        ((contents.month == String(ca_info["fM"]!) && Int(contents.day!)! >= ca_info["fD"]!) ||
                            (contents.month == String(ca_info["lM"]!) && Int(contents.day!)! <= ca_info["fD"]!))
                    }
                }
            }
            else
            {
                filterd_contents = self.contents.filter
                { (contents:Contents) -> Bool in return
                    contents.year == String(ca_info["Fyear"]!) && contents.month == String(ca_info["fM"]!) &&
                    (Int(contents.day!)! >= ca_info["fD"]! && Int(contents.day!)! <= ca_info["lD"]!)
                }
            }
        case 2:
            filterd_contents = self.contents.filter
            { (contents:Contents) -> Bool in return
                contents.year == String(ca_info["Fyear"]!) && contents.month == String(ca_info["fM"]!)
            }
        case 3:
            filterd_contents = self.contents.filter
            { (contents:Contents) -> Bool in return
                contents.year == String(ca_info["Fyear"]!)
            }
        default:
            print("error")
        }
        print("_____contents_____")
        for content in contents
        {
            print(content.lat!)
        }
        print("_____filterd_content_____")
        for cont in filterd_contents
        {
            print(cont.lat!)
        }
        for cood in coodinate_lst
        {
            map_view.removeOverlay(cood)
        }
        for pin in pin_lst
        {
            map_view.removeAnnotation(pin)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func seg_change_action(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex {
        case 0:
            ca_info = day_ca.First()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)"
        case 1:
            ca_info = week_ca.First()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 2:
            ca_info = month_ca.First()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 3:
            ca_info = year_ca.First()
            date_tf.text = "\(ca_info["Fyear"]!)年"
        default:
            ca_info = week_ca.First()
        }
        seg_index = sender.selectedSegmentIndex
        filter_content()
        draw_circle_pin()
    }
    
    @IBAction func reload_action(_ sender: Any)
    {
        fetch_data()
        filter_content()
        draw_circle_pin()
    }
    
    var coodinate_lst = [MKCircle]()
    var pin_lst = [MKPointAnnotation]()
    var color_pH = Double()
    
    func draw_circle_pin()
    {
        coodinate_lst.removeAll()
        var center: CLLocationCoordinate2D!
        for content in filterd_contents
        {
            color_pH = content.atai!
            // 地図の中心の座標.
            center = CLLocationCoordinate2DMake(Double(content.lat!)!, Double(content.lot!)!)
            // 円を描画する(半径100m).
            let myCircle: MKCircle = MKCircle(center: center, radius: CLLocationDistance(20))
            // mapViewにcircleを追加.
            map_view.addOverlay(myCircle)
            coodinate_lst.append(myCircle)
            //ピンを立てる
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(Double(content.lat!)!, Double(content.lot!)!)
//            pin.title = "pH:\(round(content.atai! * 10) / 10)"
            pin.title = ""
            pin.subtitle = "pH:\(round(content.atai! * 10) / 10)\n\(content.month!)/\(content.day!) \(content.hour!)時\(content.minute!)分"
            map_view.addAnnotation(pin)
            pin_lst.append(pin)
        }
    }
    
    @IBAction func back_action(_ sender: Any)
    {
        switch seg_index {
        case 0:
            ca_info = day_ca.getOld()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)"
        case 1:
            ca_info = week_ca.getOld()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 2:
            ca_info = month_ca.getOld()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 3:
            ca_info = year_ca.getOld()
            date_tf.text = "\(ca_info["Fyear"]!)年"
        default:
            print("error")
        }
        filter_content()
        draw_circle_pin()
    }
    
    @IBAction func ahead_action(_ sender: Any)
    {
        switch seg_index {
        case 0:
            ca_info = day_ca.getNew()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)"
        case 1:
            ca_info = week_ca.getNew()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 2:
            ca_info = month_ca.getNew()
            date_tf.text = "\(ca_info["Fyear"]!)年 \(ca_info["fM"]!)/\(ca_info["fD"]!)~\(ca_info["lM"]!)/\(ca_info["lD"]!)"
        case 3:
            ca_info = year_ca.getNew()
            date_tf.text = "\(ca_info["Fyear"]!)年"
        default:
            print("error")
        }
        filter_content()
        draw_circle_pin()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        // rendererを生成.
        let myCircleView: MKCircleRenderer = MKCircleRenderer(overlay: overlay)
        // 円の内部を赤色で塗りつぶす.
        //myCircleView.fillColor = UIColor.red
        let rgb_lst = pH_to_rgb.pH_to_RGB_lst(pH: color_pH)
        myCircleView.fillColor = UIColor(red: CGFloat(rgb_lst[0]), green: CGFloat(rgb_lst[1]), blue: CGFloat(rgb_lst[2]), alpha: 1.0)
        // 円周の線の色を黒色に設定.
        myCircleView.strokeColor = UIColor.clear
        // 円を透過させる.
        myCircleView.alpha = 0.8
        // 円周の線の太さ.
        myCircleView.lineWidth = 1.5
        return (myCircleView)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//    {
//        let testPinView = MKPinAnnotationView()
////        testPinView.annotation = annotation
//        testPinView.pinTintColor = UIColor.blue
//        testPinView.canShowCallout = true
//        return (testPinView)
//    }
    
    func initMap()
    {
       // 縮尺を設定
        var region:MKCoordinateRegion = map_view.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        map_view.setRegion(region,animated:true)
       // 現在位置表示の有効化
        map_view.showsUserLocation = true
       // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        map_view.userTrackingMode = .follow
    }
    
    func fetch_data()
    {
        _ = Database.database().reference().child("nikaho_syakujii").queryLimited(toLast: 1000).queryOrdered(byChild: "time").observe(.value)
        { snapshot in
            self.contents.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snapShot
                {
                    if let postData = snap.value as? [String:Any]
                    {
                        let outcome = postData["alpha"] as? String
                        let time = postData["time"] as? String
                        let arr:[String] = (time?.components(separatedBy: "/"))!
                        let lat = postData["lat"] as? String
                        let lot = postData["lot"] as? String
                        if (lat == nil)
                        {
                            continue
                        }
                        else
                        {
                            self.contents.append(Contents(atai: Double(outcome!)!, address: "", lat: lat!, lot: lot!, year: arr[0], month: arr[1], day: arr[2], hour: arr[3], minute: arr[4], category: "", sikensi: "", pen: ""))
                        }
                    }
                }
            }
        }
    }

}
