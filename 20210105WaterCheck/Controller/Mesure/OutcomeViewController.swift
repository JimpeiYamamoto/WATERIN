//
//  OutcomeViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/10.
//

import UIKit
import CoreLocation
import FirebaseDatabase

class OutcomeViewController: UIViewController, CLLocationManagerDelegate
{    

    var reCall = ResultCall()
    var timeClass = GetTime()
    var timeDict = [String:String]()
    var t_info = take_info()
    var l_info = location_info()
    var ref_rgb_1 = [String:[Double]]()
    var ref_rgb_2 = [String:[Double]]()
    var takenImage = UIImage()
    let geocoder = CLGeocoder()
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
    
    @IBOutlet weak var parameter: UILabel!
    @IBOutlet weak var alpha: UILabel!
    @IBOutlet weak var back_button: UIButton!
    
    var r_g = Double()
    var r_b = Double()
    var g_b = Double()
    var r_g_1 = Double()
    var r_b_1 = Double()
    var g_b_1 = Double()
    var r_g_2 = Double()
    var r_b_2 = Double()
    var g_b_2 = Double()
    var r_g_3 = Double()
    var r_b_3 = Double()
    var g_b_3 = Double()
    var alpha_num = Int()
    var alpha_pH = Double()
    var mode = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
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
        init_alpha()
    }
    
    func init_alpha()
    {
        r_g_1 = t_info.outcome_mulch!["r_1_after"]! - t_info.outcome_mulch!["g_1_after"]!
        r_b_1 = t_info.outcome_mulch!["r_1_after"]! - t_info.outcome_mulch!["b_1_after"]!
        g_b_1 = t_info.outcome_mulch!["g_1_after"]! - t_info.outcome_mulch!["b_1_after"]!
        r_g_2 = t_info.outcome_mulch!["r_2_after"]! - t_info.outcome_mulch!["g_2_after"]!
        r_b_2 = t_info.outcome_mulch!["r_2_after"]! - t_info.outcome_mulch!["b_2_after"]!
        g_b_2 = t_info.outcome_mulch!["g_2_after"]! - t_info.outcome_mulch!["b_2_after"]!
        r_g_3 = t_info.outcome_mulch!["r_3_after"]! - t_info.outcome_mulch!["g_3_after"]!
        r_b_3 = t_info.outcome_mulch!["r_3_after"]! - t_info.outcome_mulch!["b_3_after"]!
        g_b_3 = t_info.outcome_mulch!["g_3_after"]! - t_info.outcome_mulch!["b_3_after"]!
        
        if r_g_1 < 170 && r_b_1 > 80 && g_b_1 < 140{
            let pH_r_g = 6 * 0.00000001 * pow(r_g_1, 4) - 4 * 0.00001 * pow(r_g_1, 3) - 0.0083 * pow(r_g_1, 2) + 0.7737 * r_g_1 + 26.811
            let pH_g_b = 2 * 0.000001 * pow(g_b_1, 3) - 0.0003 * pow(g_b_1, 2) + 0.022 * g_b_1 + 3.1274
            r_g = r_g_1
            g_b = g_b_1
            alpha_pH = (pH_r_g + pH_g_b) / 2
            let mode = 1
        } else if r_g_3 > 100 && r_b_3 < 160 && g_b_3 < 70{
            let pH_r_g = 0.0873 * r_g_3 + 2.4524
            let pH_r_b = -0.0187 * r_b_3 + 12.833
            let pH_g_b = -0.0157 * g_b_3 + 11.013
            r_g = r_g_2
            r_b = r_b_2
            g_b = g_b_2
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
            let mode = 2
        } else{
            let pH_r_g = -0.00001 * pow(r_g_2, 3) + 0.0006 * pow(r_g_2, 2) - 0.0303 * r_g_2 + 6.4479
            let pH_r_b = -0.0000006 * pow(r_b_2, 3) + 0.0002 * pow(r_b_2, 2) - 0.036 * r_b_2 + 8.2927
            let pH_g_b = -0.0456 * g_b_2 + 9.7907
            r_g = r_g_3
            r_b = r_b_3
            g_b = g_b_3
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
            let mode = 3
        }
        parameter.text = String(round(alpha_pH * 10) / 10)
        alpha.text = "α：0"
        alpha_num = 0
    }
    
    @IBAction func plus(_ sender: Any)
    {
        alpha_num += 1
        r_g += 0.5
        r_b += 0.5
        if mode == 1{
            let pH_r_g = 6 * 0.00000001 * pow(r_g, 4) - 4 * 0.00001 * pow(r_g, 3) - 0.0083 * pow(r_g, 2) + 0.7737 * r_g + 26.811
            let pH_g_b = 2 * 0.000001 * pow(g_b, 3) - 0.0003 * pow(g_b, 2) + 0.022 * g_b + 3.1274
            alpha_pH = (pH_r_g + pH_g_b) / 2
        } else if mode == 2{
            let pH_r_g = 0.0873 * r_g + 2.4524
            let pH_r_b = -0.0187 * r_b + 12.833
            let pH_g_b = -0.0157 * g_b + 11.013
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
        } else {
            let pH_r_g = -0.00001 * pow(r_g, 3) + 0.0006 * pow(r_g, 2) - 0.0303 * r_g + 6.4479
            let pH_r_b = -0.0000006 * pow(r_b, 3) + 0.0002 * pow(r_b, 2) - 0.036 * r_b + 8.2927
            let pH_g_b = -0.0456 * g_b_2 + 9.7907
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
        }
        alpha_pH = round(alpha_pH * 10) / 10
        parameter.text = String(alpha_pH)
        alpha.text = "α：" + String(alpha_num)
    }
    
    @IBAction func minus(_ sender: Any)
    {
        alpha_num -= 1
        r_g -= 0.5
        r_b -= 0.5
        if mode == 1{
            let pH_r_g = 6 * 0.00000001 * pow(r_g, 4) - 4 * 0.00001 * pow(r_g, 3) - 0.0083 * pow(r_g, 2) + 0.7737 * r_g + 26.811
            let pH_g_b = 2 * 0.000001 * pow(g_b, 3) - 0.0003 * pow(g_b, 2) + 0.022 * g_b + 3.1274
            alpha_pH = (pH_r_g + pH_g_b) / 2
        } else if mode == 2{
            let pH_r_g = 0.0873 * r_g + 2.4524
            let pH_r_b = -0.0187 * r_b + 12.833
            let pH_g_b = -0.0157 * g_b + 11.013
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
        } else {
            let pH_r_g = -0.00001 * pow(r_g, 3) + 0.0006 * pow(r_g, 2) - 0.0303 * r_g + 6.4479
            let pH_r_b = -0.0000006 * pow(r_b, 3) + 0.0002 * pow(r_b, 2) - 0.036 * r_b + 8.2927
            let pH_g_b = -0.0456 * g_b_2 + 9.7907
            alpha_pH = (pH_r_g + pH_r_b + pH_g_b) / 3
        }
        alpha_pH = round(alpha_pH * 10) / 10
        parameter.text = String(alpha_pH)
        alpha.text = "α：" + String(alpha_num)
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
        values["pH_alpha"] = String(alpha_pH)
        values["alpha"] = String(alpha_num)
        values["red_before"] = String(t_info.outcome_mulch!["r_before"]!)
        values["green_before"] = String(t_info.outcome_mulch!["g_before"]!)
        values["blue_before"] = String(t_info.outcome_mulch!["b_before"]!)
        values["red_after"] = String(t_info.outcome_mulch!["r_after"]!)
        values["green_after"] = String(t_info.outcome_mulch!["g_after"]!)
        values["blue_after"] = String(t_info.outcome_mulch!["b_after"]!)
        for ref in ref_rgb_1
        {
            let num = ref.key.components(separatedBy: "_")[1]
            values["red_" + num] = String(ref.value[0])
            values["green_" + num] = String(ref.value[1])
            values["blue_" + num] = String(ref.value[2])
        }
        for ref in ref_rgb_2
        {
            let num = ref.key.components(separatedBy: "_")[1]
            if (String(num) == "7")
            {
                values["red_" + num + "_2"] = String(ref.value[0])
                values["green_" + num + "_2"] = String(ref.value[1])
                values["blue_" + num + "_2"] = String(ref.value[2])
            }
            values["red_" + num] = String(ref.value[0])
            values["green_" + num] = String(ref.value[1])
            values["blue_" + num] = String(ref.value[2])
        }
        let database = Database.database().reference().child("nikaho_syakujii")
        database.childByAutoId().setValue(values)
        saveOrNonSave()
    }
    
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        date_label.frame = CGRect(x: v_w * 5, y: v_h * 7, width: v_w * 94, height: v_h * 6)
        top_view.frame = CGRect(x: v_w * 3, y: v_h * 15, width: v_w * 94, height: v_h * 22)
        let t_w = top_view.frame.size.width / 100
        let t_h = top_view.frame.size.height / 100
        sub_label.frame = CGRect(x: t_w * 5, y: t_h * 3, width: t_w * 30, height: t_h * 10)
        outcome_label.frame = CGRect(x: t_w * 20, y: t_h * 15, width: t_w * 60, height: t_h * 82)
        second_v.frame = CGRect(x: v_w * 3, y: v_h * 39, width: v_w * 94, height: v_h * 10)
        let s_w = second_v.frame.size.width / 100
        let s_h = second_v.frame.size.height / 100
        paper_label.frame = CGRect(x: s_w * 5, y: s_h * 3, width: s_w * 30, height: s_h * 30)
        selected_paper_label.frame = CGRect(x: s_w * 10, y: s_h * 33, width: s_w * 80, height: s_h * 65)
        buttom_v.frame = CGRect(x: v_w * 3, y: v_h * 52, width: v_w * 94, height: v_h * 17)
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
