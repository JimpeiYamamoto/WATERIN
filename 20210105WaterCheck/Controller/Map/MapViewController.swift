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
    
    var fb_class = FirebaseClass()
    var coodinate_lst = [MKCircle]()
    var pin_lst = [MKPointAnnotation]()
    var color_pH = Double()
    var c_info = Calender_Info(fy: 0, ly: 0, fm: 0, lm: 0, fd: 0, ld: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
        serch_tf.delegate = self
        map_view.delegate = self
        initMap()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        segment_view.selectedSegmentIndex = 0
        /*
         現在の時間の情報を取得
         */
        let date = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
        c_info = Calender_Info(fy: date.year!, ly: date.year!, fm: date.month!, lm: date.month!,
                                   fd: date.day!, ld: date.day!)
        c_info =  Day_Calender().init_info(c_info: c_info)
        date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd)"
        fetchDrawCircle()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        if let searchKey = textField.text
        {
        let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                if let unwrapPlacemarks = placemarks
                {
                    if let firstPlacemark = unwrapPlacemarks.first
                    {
                        if let location = firstPlacemark.location
                        {
                            let targetCoordinate = location.coordinate
                            self.map_view.region = MKCoordinateRegion(center: targetCoordinate,
                                                                      latitudinalMeters: 500.0,
                                                                      longitudinalMeters: 500.0)
                            textField.text = ""
                        }
                    }
                }
            })
        }
        return (true)
    }
    
    func draw_circle_pin()
    {
        for cood in coodinate_lst
        {
            map_view.removeOverlay(cood)
        }
        for pin in pin_lst
        {
            map_view.removeAnnotation(pin)
        }
        coodinate_lst.removeAll()
        pin_lst.removeAll()
        for content in fb_class.filter_contents
        {
            color_pH = content.atai!
            let center = CLLocationCoordinate2DMake(Double(content.lat!)!, Double(content.lot!)!)
            let myCircle: MKCircle = MKCircle(center: center, radius: CLLocationDistance(20))
            map_view.addOverlay(myCircle)
            coodinate_lst.append(myCircle)
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(Double(content.lat!)!, Double(content.lot!)!)
            pin.title = ""
            pin.subtitle = "pH:\(round(content.atai! * 10) / 10)\n\(content.month!)/\(content.day!) \(content.hour!)時\(content.minute!)分"
            map_view.addAnnotation(pin)
            pin_lst.append(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let myCircleView: MKCircleRenderer = MKCircleRenderer(overlay: overlay)
        let rgb_lst = pH_class().pH_to_RGB_lst(pH: color_pH)
        myCircleView.fillColor = UIColor(red: CGFloat(rgb_lst[v.R]),
                                         green: CGFloat(rgb_lst[v.G]),
                                         blue: CGFloat(rgb_lst[v.B]),
                                         alpha: 0.8)
        myCircleView.strokeColor = UIColor.clear
        myCircleView.lineWidth = 1.5
        return (myCircleView)
    }

    func initMap()
    {
        var locManager = CLLocationManager()
        locManager.delegate = self
        locManager = CLLocationManager()
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
        var region:MKCoordinateRegion = map_view.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        map_view.setRegion(region,animated:true)
        map_view.showsUserLocation = true
        map_view.userTrackingMode = .follow
    }
    
    @IBAction func seg_change_action(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            c_info = Day_Calender().init_info(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd)"
        case 1:
            c_info = Week_Calender().init_info(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd) ~ \(c_info.lm)/\(c_info.ld)"
        case 2:
            c_info = Month_Calender().init_info(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)月"
        case 3:
            c_info = Year_Calender().init_info(c_info: c_info)
            date_tf.text = "\(c_info.fy)年"
        default:
            print("segment Erorr")
        }
        segment_view.selectedSegmentIndex = sender.selectedSegmentIndex
        fetchDrawCircle()
    }

    @IBAction func reload_action(_ sender: Any){
        fetchDrawCircle()
    }
    
    @IBAction func back_action(_ sender: Any)
    {
        switch segment_view.selectedSegmentIndex
        {
        case 0:
            c_info = Day_Calender().back_day(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd)"
        case 1:
            c_info = Week_Calender().back_week(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd) ~ \(c_info.lm)/\(c_info.ld)"
        case 2:
            c_info = Month_Calender().back_week(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)月"
        case 3:
            c_info = Year_Calender().back_year(c_info: c_info)
            date_tf.text = "\(c_info.fy)年"
        default:
            print("segment Erorr")
        }
//        fb_class.fetch_firebase(subject: v.PH)
//        fb_class.filter_content(start: c_info.f_str, stop: c_info.l_str)
//        draw_circle_pin()
        fetchDrawCircle()
    }
    
    @IBAction func ahead_action(_ sender: Any)
    {
        switch segment_view.selectedSegmentIndex
        {
        case 0:
            c_info = Day_Calender().proceed_day(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd)"
        case 1:
            c_info = Week_Calender().proceed_week(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd) ~ \(c_info.lm)/\(c_info.ld)"
        case 2:
            c_info = Month_Calender().proceed_month(c_info: c_info)
            date_tf.text = "\(c_info.fy)年 \(c_info.fm)月"
        case 3:
            c_info = Year_Calender().proceed_year(c_info: c_info)
            date_tf.text = "\(c_info.fy)年"
        default:
            print("segment Erorr")
        }
        fetchDrawCircle()
    }
    
    func fetchDrawCircle() {
        fb_class.contents.removeAll()
        _ = Database.database().reference().child(v.STORAGE_C1).child(v.PH).queryOrderedByKey().observe(.value)
        { [self] snapshot in
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]
            {
                fb_class.fetchFirebase(snapShot: snapShot, subject: v.PH)
                fb_class.filter_content(start: c_info.f_str, stop: c_info.l_str)
                draw_circle_pin()
            }
        }
    }
}
