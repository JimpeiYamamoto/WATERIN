//
//  ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import CoreLocation
import Firebase

class ViewController: UIViewController, UITabBarDelegate{

    @IBOutlet weak var pH_startButton: UIButton!
    @IBOutlet weak var setting_view: UIView!
    @IBOutlet weak var sub_label: UILabel!
    @IBOutlet weak var sub_tf: UITextField!
    @IBOutlet weak var sub_back_button: UIButton!
    @IBOutlet weak var sub_ahead_button: UIButton!
    @IBOutlet weak var paper_label: UILabel!
    @IBOutlet weak var paper_tf: UITextField!
    @IBOutlet weak var paper_back_button: UIButton!
    @IBOutlet weak var paper_ahead_button: UIButton!
    
    @IBOutlet weak var top_v: UIView!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var latest_outcome_label: UILabel!
    @IBOutlet weak var latest_paper_label: UILabel!
    @IBOutlet weak var top_sub_label: UILabel!
    @IBOutlet weak var top_paper_label: UILabel!
    @IBOutlet weak var sample_image: UIImageView!
    @IBOutlet weak var right_v: UIView!
    
    var result_call = ResultCall()
    var t_info = take_info()
    var sub_num = 0
    let sub_lst = ["pH", "Cl"]
    let paper_lst = ["MARCHERY-NAGEL", "Serim MONITOR FOR CHLORINE"]
    let paper_photo_name_lst = ["m_n_image", "cl_paper"]
    var locationManager: CLLocationManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
        UpgradeNotice.shared.fire()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setupLocationManager()
        t_info.subject = "pH"
        t_info.paper = "MARCHERY-NAGEL"
        t_info.category = "未分類"
        
        show_latest()
        sample_image.image = UIImage(named: "m_n_image.jpg")
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
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
    }
    
    func show_latest()
    {
        result_call.whichSubject = t_info.subject!
        top_sub_label.text = t_info.subject
        top_paper_label.text = t_info.paper
        paper_tf.text = t_info.paper
        sub_tf.text = t_info.subject
        result_call.getContents()
        date_label.adjustsFontSizeToFitWidth = true
        let cnt = result_call.ataiList.count
        if (cnt == 0)
        {
            date_label.text = "--月--日--:--"
            latest_paper_label.text = "--------"
            latest_outcome_label.text = "--.-"
        }
        else
        {
            let month = add_zero(num: String(result_call.monthList[cnt - 1]))
            let date = add_zero(num: String(result_call.dayList[cnt - 1]))
            let hour = add_zero(num: String(result_call.hourList[cnt - 1]))
            let minute = add_zero(num: String(result_call.minuteList[cnt - 1]))
            date_label.text = "\(month)月\(date)日 \(hour):\(minute)"
            latest_paper_label.text = paper_lst[sub_num % 2]
            var outcome = result_call.ataiList[cnt - 1]
            outcome = round(outcome * 10) / 10
            latest_outcome_label.text = "\(outcome)"
        }
    }
    
    func add_zero(num:String) -> String
    {
        if (Int(num)! < 10)
        {
            return ("0" + num)
        }
        else
        {
            return (num)
        }
    }
    
    @IBAction func right_subject(_ sender: Any)
    {
        sub_num += 1
        sub_tf.text = sub_lst[sub_num % 2]
        paper_tf.text = paper_lst[sub_num % 2]
        t_info.subject = sub_tf.text
        t_info.paper = paper_tf.text
        show_latest()
        sample_image.image = UIImage(named: paper_photo_name_lst[sub_num % 2])
    }
    
    @IBAction func left_subject(_ sender: Any)
    {
        sub_num += 1
        sub_tf.text = sub_lst[sub_num % 2]
        paper_tf.text = paper_lst[sub_num % 2]
        t_info.subject = sub_tf.text
        t_info.paper = paper_tf.text
        show_latest()
        sample_image.image = UIImage(named: paper_photo_name_lst[sub_num % 2])
    }
    
    @IBAction func pH_startAction(_ sender: Any)
    {
        if (sub_tf.text == "pH")
        {
            let mesureVC = storyboard?.instantiateViewController(identifier: "cal1") as! Cal1ViewController
            mesureVC.t_info = self.t_info
            navigationController?.pushViewController(mesureVC, animated: true)
        }
        else
        {
            let mesureVC = storyboard?.instantiateViewController(identifier: "cl_cal") as! Cl_Cal1ViewController
            mesureVC.t_info = self.t_info
            navigationController?.pushViewController(mesureVC, animated: true)
        }
    }
    
    @IBAction func goSetAction(_ sender: Any) {
        let setVC = storyboard?.instantiateViewController(identifier: "setting") as! SetMainViewController
        navigationController?.pushViewController(setVC, animated: true)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    func set_view()
    {
        paper_tf.adjustsFontSizeToFitWidth = true
        paper_label.adjustsFontSizeToFitWidth = true
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        pH_startButton.frame = CGRect(x: v_w * 37, y: v_h * 73, width: v_w * 26, height: v_h * 20)
        pH_startButton.imageView?.contentMode = .scaleAspectFit
        pH_startButton.contentHorizontalAlignment = .fill
        pH_startButton.contentVerticalAlignment = .fill
        sub_back_button.imageView?.contentMode = .scaleAspectFit
        sub_back_button.contentHorizontalAlignment = .fill
        sub_back_button.contentVerticalAlignment = .fill
        sub_ahead_button.imageView?.contentMode = .scaleAspectFit
        sub_ahead_button.contentHorizontalAlignment = .fill
        sub_ahead_button.contentVerticalAlignment = .fill
        paper_back_button.imageView?.contentMode = .scaleAspectFit
        paper_back_button.contentHorizontalAlignment = .fill
        paper_back_button.contentVerticalAlignment = .fill
        paper_ahead_button.imageView?.contentMode = .scaleAspectFit
        paper_ahead_button.contentHorizontalAlignment = .fill
        paper_ahead_button.contentVerticalAlignment = .fill
        setting_view.frame = CGRect(x: v_w * 5, y: v_h * 48, width: v_w * 90, height: v_h * 27)
        let s_w = setting_view.frame.size.width / 100
        let s_h = setting_view.frame.size.height / 100
        sub_label.frame = CGRect(x: s_w * 4, y: s_h * 4, width: s_w * 20, height: s_h * 10)
        sub_tf.frame = CGRect(x: s_w * 20, y: s_h * 19, width: s_w * 60, height: s_h * 20)
        sub_tf.layer.borderColor = UIColor.black.cgColor
        sub_tf.layer.borderWidth = 1.0
        sub_back_button.frame = CGRect(x: s_w * 4, y: s_h * 19, width: s_w * 14, height: s_h * 20)
        sub_ahead_button.frame = CGRect(x: s_w * 82, y: s_h * 19, width: s_w * 14, height: s_h * 20)
        paper_label.frame = CGRect(x: s_w * 4, y: s_h * 48, width: s_w * 19, height: s_h * 10)
        paper_tf.frame = CGRect(x: s_w * 20, y: s_h * 67, width: s_w * 60, height: s_h * 20)
        paper_tf.layer.borderColor = UIColor.black.cgColor
        paper_tf.layer.borderWidth = 1.0
        paper_back_button.frame = CGRect(x: s_w * 4, y: s_h * 67, width: s_w * 14, height: s_h * 20)
        paper_ahead_button.frame = CGRect(x: s_w * 82, y: s_h * 67, width: s_w * 14, height: s_h * 20)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        top_v.frame = CGRect(x: v_w * 4, y: v_h * 12, width: v_w * 44, height: v_h * 34)
        let t_w = top_v.frame.size.width / 100
        let t_h = top_v.frame.size.height / 100
        top_sub_label.frame = CGRect(x: t_w * 3, y: t_h * 3, width: t_w * 40, height: t_h * 15)
        latest_outcome_label.frame = CGRect(x: t_w * 3, y: t_w * 25, width: t_w * 94, height: t_h * 50)
        date_label.frame = CGRect(x: t_w * 3, y: t_h * 75, width: t_w * 94, height: t_h * 10)
        latest_paper_label.frame = CGRect(x: t_w * 3, y: t_h * 87, width: t_w * 94, height: t_h * 10)
        right_v.frame = CGRect(x: v_w * 50, y: v_h * 12, width: v_w * 46, height: v_h * 34)
        let r_w = right_v.frame.size.width / 100
        let r_h = right_v.frame.size.height / 100
        top_paper_label.frame = CGRect(x: r_w * 2, y: r_h * 3, width: r_w * 96, height: r_h * 15)
        sample_image.frame = CGRect(x: r_w * 3, y: r_h * 24, width: r_w * 94, height: r_h * 71)
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        pH_startButton.layer.cornerRadius = 20.0
        setting_view.layer.borderWidth = 1.0
        setting_view.layer.borderColor = UIColor.black.cgColor
        top_v.layer.borderWidth = 1.0
        top_v.layer.borderColor = UIColor.black.cgColor
        right_v.layer.borderWidth = 1.0
        right_v.layer.borderColor = UIColor.black.cgColor
    }
    
}
