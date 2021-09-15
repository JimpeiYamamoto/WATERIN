//
//  OutcomeViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/10.
//

import UIKit
import CoreLocation
import FirebaseDatabase


var r_after = 0.0
var g_after = 0.0
var b_after = 0.0


var pH_result = 0.0
var pH_result2 = 0.0

var r_g = r_after - g_after
var r_b = r_after - b_after

var r_g_hozon = r_after - g_after
var r_b_hozon = r_after - b_after

var i = 0.0

var r_g2 = 0.0
var r_b2 = 0.0

class OutcomeViewController: UIViewController, CLLocationManagerDelegate
{    
    var reCall = ResultCall()
    var timeClass = GetTime()
    var timeDict = [String:String]()
    
    var t_info = take_info()
    var l_info = location_info()
    
    var takenImage = UIImage()
    let geocoder = CLGeocoder()
    var locationManager: CLLocationManager!
    @IBOutlet weak var back_button: UIButton!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    
    @IBOutlet weak var parameter: UILabel!
    @IBOutlet weak var alpha: UILabel!
    
    
    @IBAction func plus(_ sender: Any) {
        i = i + 1
        
        r_g2 = r_g + 0.2 * i
        r_b2 = r_b + 0.2 * i
        
        let pH_r_g = -0.00001 * pow(r_g2, 3) + 0.0006 * pow(r_g2, 2) - 0.0303 * r_g2 + 6.4479
        let pH_r_b = -0.0000006 * pow(r_b2, 3) + 0.0002 * pow(r_b2, 2) - 0.036 * r_b2 + 8.2927
        
        pH_result2 = (pH_r_g + pH_r_b) / 2
        
        pH_result2 = round(pH_result2 * 10)
        pH_result2 = pH_result2 / 10
        
        parameter.text = String(pH_result2)
        
        alpha.text = "α：" + String(i)
        
//        UserDefaults.standard.set(r_g_alpha, forKey: "r_g_alpha")
//        UserDefaults.standard.set(r_b_alpha, forKey: "r_b_alpha")

        
        
        
    }
    
    
    @IBAction func minus(_ sender: Any) {
        i = i - 1
        
        r_g2 = r_g + 0.2 * i
        r_b2 = r_b + 0.2 * i
        
        let pH_r_g = -0.00001 * pow(r_g2, 3) + 0.0006 * pow(r_g2, 2) - 0.0303 * r_g2 + 6.4479
        let pH_r_b = -0.0000006 * pow(r_b2, 3) + 0.0002 * pow(r_b2, 2) - 0.036 * r_b2 + 8.2927
        
        
        pH_result2 = (pH_r_g + pH_r_b) / 2
        
        pH_result2 = round(pH_result2 * 10)
        pH_result2 = pH_result2 / 10
        
        parameter.text = String(pH_result2)
        
        alpha.text = "α：" + String(i)
        
        
//        UserDefaults.standard.set(r_g_alpha, forKey: "r_g_alpha")
//        UserDefaults.standard.set(r_b_alpha, forKey: "r_b_alpha")
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //現在時刻の取得
        timeDict = timeClass.getTime()
        t_info.year = timeDict["year"]!
        t_info.month = timeDict["month"]!
        t_info.day = timeDict["day"]!
        t_info.hour = timeDict["hour"]!
        t_info.minute = timeDict["minute"]!
        //位置情報の取得を開始する
        setupLocationManager()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        print("\(t_info.subject!)を測定しました。")
        print("試験紙は\(t_info.paper!)です")
        show_outcome()
        
        
        r_after = t_info.outcome_mulch!["r_after"]!
        g_after = t_info.outcome_mulch!["g_after"]!
        b_after = t_info.outcome_mulch!["b_after"]!

        
        var r_g = r_after - g_after
        var r_b = r_after - b_after
        
        
        let pH_r_g = -0.00001 * pow(r_g, 3) + 0.0006 * pow(r_g, 2) - 0.0303 * r_g + 6.4479
        let pH_r_b = -0.0000006 * pow(r_b, 3) + 0.0002 * pow(r_b, 2) - 0.036 * r_b + 8.2927
        
        pH_result = ((pH_r_g + pH_r_b) / 2)
        pH_result = round(pH_result * 10)
        pH_result = pH_result / 10
        
        parameter.text = String(pH_result)
        alpha.text = "α：0"
        
    }
    
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
    
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        date_label.frame = CGRect(x: v_w * 5, y: v_h * 7, width: v_w * 94, height: v_h * 6)
        top_view.frame = CGRect(x: v_w * 3, y: v_h * 15, width: v_w * 94, height: v_h * 20)
        let t_w = top_view.frame.size.width / 100
        let t_h = top_view.frame.size.height / 100
        sub_label.frame = CGRect(x: t_w * 5, y: t_h * 3, width: t_w * 30, height: t_h * 10)
        outcome_label.frame = CGRect(x: t_w * 20, y: t_h * 15, width: t_w * 60, height: t_h * 82)
        second_v.frame = CGRect(x: v_w * 3, y: v_h * 40, width: v_w * 94, height: v_h * 8)
        let s_w = second_v.frame.size.width / 100
        let s_h = second_v.frame.size.height / 100
        paper_label.frame = CGRect(x: s_w * 5, y: s_h * 3, width: s_w * 30, height: s_h * 30)
        selected_paper_label.frame = CGRect(x: s_w * 10, y: s_h * 33, width: s_w * 80, height: s_h * 65)
        buttom_v.frame = CGRect(x: v_w * 3, y: v_h * 50, width: v_w * 94, height: v_h * 15)
        let b_w = buttom_v.frame.size.width / 100
        let b_h = buttom_v.frame.size.height / 100
        water_label.frame = CGRect(x: b_w * 5, y: b_h * 3, width: b_w * 30, height: b_h * 15)
        evaluate_label.frame = CGRect(x: b_w * 10, y:b_h * 20, width: b_w * 80, height: b_h * 20)
        cate_label.frame = CGRect(x: b_w * 5, y: b_h * 43, width: b_w * 30, height: b_h * 15)
        cate_tf.frame = CGRect(x: b_w * 20, y: b_h * 63, width: b_w * 60, height: b_h * 30)
        change_cate_button.frame = CGRect(x: b_w * 82, y: b_h * 63, width: b_w * 16, height: b_h * 30)
        back_button.frame = CGRect(x: v_w * 30, y: v_h * 86, width: v_w * 40, height: v_h * 13)
        cate_tf.layer.borderWidth = 1.0
        cate_tf.layer.borderColor = UIColor.black.cgColor
        back_button.imageView?.contentMode = .scaleAspectFit
        back_button.contentHorizontalAlignment = .fill
        back_button.contentVerticalAlignment = .fill
        change_cate_button.imageView?.contentMode = .scaleAspectFit
        change_cate_button.contentHorizontalAlignment = .fill
        change_cate_button.contentVerticalAlignment = .fill
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        top_view.layer.borderColor = UIColor.black.cgColor
        top_view.layer.borderWidth = 1.0

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
    
    func show_outcome()
    {
        date_label.text = "\(add_zero(num:t_info.year!))年 \(add_zero(num:t_info.month!))月\(add_zero(num:t_info.day!))日 \(add_zero(num:t_info.hour!)):\(add_zero(num:t_info.minute!))"
        let outcome = round(t_info.outcome_mulch!["pH_result"]! * 10)
        outcome_label.text = String(outcome / 10)
        selected_paper_label.text = t_info.paper
        evaluate_label.text = judge_water(outcome: t_info.outcome_mulch!["pH_result"]!)
        cate_tf.text = t_info.category!
    }
    
    @IBAction func change_cate_action(_ sender: Any)
    {
        let selectVC = (storyboard?.instantiateViewController(identifier: "selectCate"))! as SelectCategoryMesureViewController
        selectVC.whichSubject = t_info.subject!
        navigationController?.pushViewController(selectVC, animated: true)
    }
    

    @IBAction func finish_action(_ sender: Any)
    {
        var values = [String:String]()
        values["time"] = "\(t_info.year!)/\(t_info.month!)/\(t_info.day!)/\(t_info.hour!)/\(t_info.minute!)"
        values["subject"] = t_info.subject
        values["sikenshi"] = t_info.paper
        values["pH"] = String(t_info.outcome_mulch!["pH_result"]!)
        values["address"] = l_info.address
        values["lot"] = l_info.lot
        values["lat"] = l_info.lat
        values["prefecture"] = l_info.admin
        values["place_name"] = l_info.place_name
        values["subThoroughfare"] = l_info.subthr
        values["taken_ok"] = "ok"
        values["category"] = t_info.category
        
        values["pH_alpha"] = String(pH_result2)
        values["alpha"] = String(i)
        values["red_before"] = String(t_info.outcome_mulch!["r_before"]!)
        values["green_before"] = String(t_info.outcome_mulch!["g_before"]!)
        values["blue_before"] = String(t_info.outcome_mulch!["b_before"]!)
        values["red_after"] = String(t_info.outcome_mulch!["r_after"]!)
        values["green_after"] = String(t_info.outcome_mulch!["g_after"]!)
        values["blue_after"] = String(t_info.outcome_mulch!["b_after"]!)
        
        values["red_0"] = String(t_info.outcome_mulch!["r_0"]!)
        values["red_1"] = String(t_info.outcome_mulch!["r_1"]!)
        values["red_2"] = String(t_info.outcome_mulch!["r_2"]!)
        values["red_3"] = String(t_info.outcome_mulch!["r_3"]!)
        values["red_4"] = String(t_info.outcome_mulch!["r_4"]!)
        values["red_5"] = String(t_info.outcome_mulch!["r_5"]!)
        values["red_6"] = String(t_info.outcome_mulch!["r_6"]!)
        values["red_7"] = String(t_info.outcome_mulch!["r_7"]!)
        values["red_7_2"] = String(t_info.outcome_mulch!["r_7_2"]!)
        values["red_8"] = String(t_info.outcome_mulch!["r_8"]!)
        values["red_9"] = String(t_info.outcome_mulch!["r_9"]!)
        values["red_10"] = String(t_info.outcome_mulch!["r_10"]!)
        values["red_11"] = String(t_info.outcome_mulch!["r_11"]!)
        values["red_12"] = String(t_info.outcome_mulch!["r_12"]!)
        values["red_13"] = String(t_info.outcome_mulch!["r_13"]!)
        values["red_14"] = String(t_info.outcome_mulch!["r_14"]!)
        
        values["green_0"] = String(t_info.outcome_mulch!["g_0"]!)
        values["green_1"] = String(t_info.outcome_mulch!["g_1"]!)
        values["green_2"] = String(t_info.outcome_mulch!["g_2"]!)
        values["green_3"] = String(t_info.outcome_mulch!["g_3"]!)
        values["green_4"] = String(t_info.outcome_mulch!["g_4"]!)
        values["green_5"] = String(t_info.outcome_mulch!["g_5"]!)
        values["green_6"] = String(t_info.outcome_mulch!["g_6"]!)
        values["green_7"] = String(t_info.outcome_mulch!["g_7"]!)
        values["green_7_2"] = String(t_info.outcome_mulch!["g_7_2"]!)
        values["green_8"] = String(t_info.outcome_mulch!["g_8"]!)
        values["green_9"] = String(t_info.outcome_mulch!["g_9"]!)
        values["green_10"] = String(t_info.outcome_mulch!["g_10"]!)
        values["green_11"] = String(t_info.outcome_mulch!["g_11"]!)
        values["green_12"] = String(t_info.outcome_mulch!["g_12"]!)
        values["green_13"] = String(t_info.outcome_mulch!["g_13"]!)
        values["green_14"] = String(t_info.outcome_mulch!["g_14"]!)
        
        values["blue_0"] = String(t_info.outcome_mulch!["b_0"]!)
        values["blue_1"] = String(t_info.outcome_mulch!["b_1"]!)
        values["blue_2"] = String(t_info.outcome_mulch!["b_2"]!)
        values["blue_3"] = String(t_info.outcome_mulch!["b_3"]!)
        values["blue_4"] = String(t_info.outcome_mulch!["b_4"]!)
        values["blue_5"] = String(t_info.outcome_mulch!["b_5"]!)
        values["blue_6"] = String(t_info.outcome_mulch!["b_6"]!)
        values["blue_7"] = String(t_info.outcome_mulch!["b_7"]!)
        values["blue_7_2"] = String(t_info.outcome_mulch!["b_7_2"]!)
        values["blue_8"] = String(t_info.outcome_mulch!["b_8"]!)
        values["blue_9"] = String(t_info.outcome_mulch!["b_9"]!)
        values["blue_10"] = String(t_info.outcome_mulch!["b_10"]!)
        values["blue_11"] = String(t_info.outcome_mulch!["b_11"]!)
        values["blue_12"] = String(t_info.outcome_mulch!["b_12"]!)
        values["blue_13"] = String(t_info.outcome_mulch!["b_13"]!)
        values["blue_14"] = String(t_info.outcome_mulch!["b_14"]!)
        
        
        
        let database = Database.database().reference().child("nikaho_syakujii")
        database.childByAutoId().setValue(values)
        saveOrNonSave()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height = tableView.frame.size.height
        switch indexPath.row {
        case 1:
            height /= 4
        default:
            height /= 8
        }
        return (height)
    }

    //カテゴリー変更ボタンを押したら呼ばれる
    @objc func changeCateEvent(_ sender: UIButton)
    {
        let selectVC = (storyboard?.instantiateViewController(identifier: "selectCate"))! as SelectCategoryMesureViewController
        selectVC.whichSubject = t_info.subject!
        navigationController?.pushViewController(selectVC, animated: true)
    }

    func saveOrNonSave()
    {
        // styleをActionSheetに設定
        let alertSheet = UIAlertController(title: "今回の測定結果を保存しますか？", message: "保存をすると、グラフで表示することができます", preferredStyle: UIAlertController.Style.actionSheet)
        let action1 = UIAlertAction(title: "はい", style: UIAlertAction.Style.default, handler: { [self]
                   (action: UIAlertAction!) in
            //ここに処理を書いていく
            reCall.whichSubject = t_info.subject!
            reCall.getContents()
            //appendしてから保存する
            reCall.ataiList.append(t_info.outcome_mulch!["pH_result"]!)
        
            if (l_info.address == nil)
            {
                reCall.addressList.append("")
                reCall.latList.append("")
                reCall.lotList.append("")
            }
            else
            {
                reCall.addressList.append(l_info.address!)
                reCall.latList.append(l_info.lat!)
                reCall.lotList.append(l_info.lot!)
            }
            reCall.yearList.append(Int(t_info.year!)!)
            reCall.monthList.append(Int(t_info.month!)!)
            reCall.dayList.append(Int(t_info.day!)!)
            reCall.hourList.append(Int(t_info.hour!)!)
            reCall.minuteList.append(Int(t_info.minute!)!)
            reCall.categoryList.append(t_info.category!)
            reCall.sikensiList.append(t_info.paper!)
            reCall.penList.append(t_info.paper!)
            reCall.DataAppendSave()
            navigationController?.popToViewController(ofClass: ViewController.self)
               })
        let action2 = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.destructive, handler: { [self]
                   (action: UIAlertAction!) in
            navigationController?.popToViewController(ofClass: ViewController.self)
               })
        let action3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
                   (action: UIAlertAction!) in
               })
               alertSheet.addAction(action1)
               alertSheet.addAction(action2)
               alertSheet.addAction(action3)
        self.present(alertSheet, animated: true, completion: nil)
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        // 位置情報取得許可ダイアログの表示
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        // マネージャの設定
        let status = CLLocationManager.authorizationStatus()
        // ステータスごとの処理
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            // 位置情報取得を開始
            print("位置情報取得を開始")
            locationManager.startUpdatingLocation()
        }
    }
    //位置情報が更新されるたびに呼ばれるメソッド
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [ CLLocation ] ) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        // 位置情報を格納する
        self.l_info.lat = String(latitude!)
        self.l_info.lot = String(longitude!)
        print("lat:", l_info.lat!)
        print("lot:", l_info.lot!)
        //表示更新
        if let location = locations.first {
            //逆ジオコーディング
            self.geocoder.reverseGeocodeLocation( location, completionHandler: { ( placemarks, error ) in
                if let placemark = placemarks?.first {
                    //住所
                    self.l_info.admin = placemark.administrativeArea == nil ? "" : placemark.administrativeArea!
                    self.l_info.locality = placemark.locality == nil ? "" : placemark.locality!
                    let subLocality = placemark.subLocality == nil ? "" : placemark.subLocality!
                    let thoroughfare = placemark.thoroughfare == nil ? "" : placemark.thoroughfare!
                    self.l_info.subthr = placemark.subThoroughfare == nil ? "" : placemark.subThoroughfare!
                    self.l_info.place_name = !thoroughfare.contains( subLocality ) ? subLocality : thoroughfare
                    print("administrativeArea:", self.l_info.admin!)
                    print("locality:", self.l_info.locality!)
                    print("placeName:", self.l_info.place_name!)
                    print("subThoroughfare:", self.l_info.subthr!)
                    self.l_info.address = self.l_info.admin! + self.l_info.locality! + self.l_info.place_name! + self.l_info.subthr!
                    print("addres:", self.l_info.address!)
                }
            })
        }
    }
    
    func judge_water(outcome : Double) -> String
    {
        if (outcome < 5.8)
        {
            return ("強酸")
        }
        if (outcome > 8.6)
        {
            return ("強アルカリ")
        }
        if (outcome < 6.8)
        {
            return ("弱酸")
        }
        if (outcome > 7.2)
        {
            return ("弱アルカリ")
        }
        return ("中性")
    }
    
    func judge_water2(outcome : Double)->[String]
    {
        var message_list = [String]()
        var drink_message = String()
        var skin_massage = String()
        switch t_info.subject {
        case "pH":
            if (outcome >= 6.7 && outcome <= 7.3)
            {
                drink_message = "飲料水に適した水質です。"
                skin_massage = "肌に優しい水質です。"
            }
            else if (outcome < 6.7 && outcome >= 6.0)
            {
                drink_message = "少し酸性に偏ってます。"
                skin_massage = "肌の弱い方は注意が必要です。"
            }
            else if (outcome > 7.3 && outcome <= 8.0)
            {
                drink_message = "少しアルカリ性に偏ってます。"
                skin_massage = "肌の弱い方は注意が必要です。"
            }
            else if (outcome > 8.0)
            {
                drink_message = "アルカリ性に偏ってます。"
                skin_massage = "肌の弱い方は注意が必要です。"
            }
            else
            {
                drink_message = "酸性に偏ってます。"
                skin_massage = "肌の弱い方は注意が必要です。"
            }
        default:
            drink_message = "未定義"
            skin_massage = "未定義"
        }
        message_list.append(drink_message)
        message_list.append(skin_massage)
        return (message_list)
    }
    

}
