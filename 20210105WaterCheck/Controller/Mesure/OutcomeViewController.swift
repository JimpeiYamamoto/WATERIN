//
//  OutcomeViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/10.
//

import UIKit
import CoreLocation

class OutcomeViewController: UIViewController, CLLocationManagerDelegate
{
    var t_info = take_info()
    let time_info = TimeClass()
    var l_info = location_info()
    var locationManager: CLLocationManager!

    @IBOutlet weak var top_view: UIView!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var sub_label: UILabel!
    @IBOutlet weak var outcome_label: UILabel!
    @IBOutlet weak var second_v: UIView!
    @IBOutlet weak var paper_label: UILabel!
    @IBOutlet weak var selected_paper_label: UILabel!
    @IBOutlet weak var buttom_v: UIView!
    @IBOutlet weak var water_label: UILabel!
    @IBOutlet weak var evaluate_label: UILabel!
    @IBOutlet weak var cate_label: UILabel!
    @IBOutlet weak var cate_tf: UITextField!
    @IBOutlet weak var change_cate_button: UIButton!
    @IBOutlet weak var back_button: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupLocationManager()
        time_info.get_now_time()
        show_info()
    }
    
    func show_info()
    {
        date_label.text = "\(time_info.month)月\(time_info.day)日 \(time_info.hour):\(time_info.minute)"
        if (t_info.subject == "Cl")
        {
            outcome_label.text = String(round(t_info.outcome! * 10) / 10) + " ppm"
        }
        else
        {
            outcome_label.text = String(round(t_info.outcome! * 10) / 10)
        }
        outcome_label.adjustsFontSizeToFitWidth = true
        selected_paper_label.text = t_info.paper
        let pH_Class = pH_class()
        evaluate_label.text = pH_Class.evaluate_pH(outcome : t_info.outcome!)
        cate_tf.text = t_info.category!
        sub_label.text = t_info.subject
    }
    

    @IBAction func change_cate_action(_ sender: Any)
    {
        let selectVC = (storyboard?.instantiateViewController(identifier: "selectCate"))! as SelectCategoryMesureViewController
        selectVC.whichSubject = t_info.subject!
        navigationController?.pushViewController(selectVC, animated: true)
    }
        
    @IBAction func finish_action(_ sender: Any)
    {
        //Strageに画像を送信
        let fb_class = FirebaseClass()
        fb_class.generatorID(10)
        fb_class.upload_images_storage(t_info: t_info, time_info: time_info)
        fb_class.upload_t_info_database(t_info: t_info, l_info: l_info, time_info: time_info)
        show_alert(title: "今回の測定結果を保存しますか？",
                   msg: "保存するとグラフによる可視化や結果のシェアが可能です",
                   yes_msg: "はい", no_msg: "いいえ")
    }
    
    func show_alert(title:String, msg:String, yes_msg: String, no_msg:String)
    {
        
        let alertSheet = UIAlertController(title: title, message: msg,
                                           preferredStyle: UIAlertController.Style.actionSheet)
        let action1 = UIAlertAction(title: yes_msg, style: UIAlertAction.Style.default, handler:
        { [self] (action: UIAlertAction!) in
            ud_save_info()
            navigationController?.popToViewController(ofClass: ViewController.self)
        })
        let action2 = UIAlertAction(title: no_msg, style: UIAlertAction.Style.destructive, handler:
        { [self] (action: UIAlertAction!) in
            navigationController?.popToViewController(ofClass: ViewController.self)
        })
        alertSheet.addAction(action1)
        alertSheet.addAction(action2)
        self.present(alertSheet, animated: true, completion: nil)
    }
    
    func ud_save_info()
    {
        let ud_data = UD_data()
        ud_data.ud_data_append(subject: t_info.subject!, t_info: t_info,
                               time_info: time_info, l_info: l_info)
        ud_data.ud_data_save(subject: t_info.subject!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        l_info.lat = String(latitude!)
        l_info.lot = String(longitude!)
        l_info.reverse_geo_coding(locations: locations)
    }
    
    func setupLocationManager()
    {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse ||  status == .authorizedAlways
        {
            locationManager.distanceFilter = 10
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
}
