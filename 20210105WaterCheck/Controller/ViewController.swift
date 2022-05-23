//
//  ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import CoreLocation
import Firebase

class ViewController: UIViewController, UITabBarDelegate
{
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
    
    var ud_data = UD_data()
    var t_info = take_info()
    var location = location_info()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        init_view()
        
        t_info.subject = v.PH
        t_info.paper = v.MARCHERY
        t_info.paper_pack_image_path = v.MARCHERY_PACK_IMG_PATH
        t_info.category = v.UNCATEGORIZE
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        load_set_view()
        location.setupLocationManager()
        show_latest_measure_info()
    }
    
    func show_latest_measure_info()
    {
        ud_data.getContents(subject: t_info.subject!)
        top_sub_label.text = t_info.subject
        top_paper_label.text = t_info.paper
        paper_tf.text = t_info.paper
        sub_tf.text = t_info.subject
        sample_image.image = UIImage(named: t_info.paper_pack_image_path!)
        date_label.adjustsFontSizeToFitWidth = true
        let cnt = ud_data.outcomeList.count
        print("cnt=",cnt)
        print("month_cnt=",ud_data.monthList.count)
        if (cnt == 0)
        {
            date_label.text = "--月--日--:--"
            latest_paper_label.text = "--------"
            latest_outcome_label.text = "--.-"
        }
        else
        {
            let month = ud_data.monthList[cnt - 1]
            let date = ud_data.dayList[cnt - 1]
            let hour = ud_data.hourList[cnt - 1]
            let minute = ud_data.minuteList[cnt - 1]
            date_label.text = "\(month)月\(date)日 \(hour):\(minute)"
            latest_paper_label.text = t_info.paper
            latest_outcome_label.text = "\(round(ud_data.outcomeList[cnt - 1] * 10) / 10)"
        }
    }

    @IBAction func right_subject(_ sender: Any)
    {
        if (t_info.subject == v.PH)
        {
            t_info.subject = v.CL
            t_info.paper = v.SERIM
            t_info.paper_pack_image_path = v.SERIM_PACK_IMG_PATH
            
        }
        else
        {
            t_info.subject = v.PH
            t_info.paper = v.MARCHERY
            t_info.paper_pack_image_path = v.MARCHERY_PACK_IMG_PATH
        
        }
        show_latest_measure_info()
    }
    
    @IBAction func left_subject(_ sender: Any)
    {
        if (t_info.subject == v.PH)
        {
            t_info.subject = v.CL
            t_info.paper = v.SERIM
            t_info.paper_pack_image_path = v.SERIM_PACK_IMG_PATH
        }
        else
        {
            t_info.subject = v.PH
            t_info.paper = v.MARCHERY
            t_info.paper_pack_image_path = v.MARCHERY_PACK_IMG_PATH
        }
        show_latest_measure_info()
    }
    
    @IBAction func pH_startAction(_ sender: Any)
    {
        if (t_info.subject == v.PH)
        {
            let mesureVC = storyboard?.instantiateViewController(identifier: "cal1") as! pH_Cal1ViewController
            mesureVC.t_info = self.t_info
            navigationController?.pushViewController(mesureVC, animated: true)
        }
        else if (t_info.subject == v.CL)
        {
            let mesureVC = storyboard?.instantiateViewController(identifier: "cl_cal") as! Cl_Cal1ViewController
            mesureVC.t_info = self.t_info
            navigationController?.pushViewController(mesureVC, animated: true)
        }
        else
        {
            print("start_action_error")
        }
    }
    
    @IBAction func goSetAction(_ sender: Any)
    {
        let setVC = storyboard?.instantiateViewController(identifier: "setting") as! SetMainViewController
        navigationController?.pushViewController(setVC, animated: true)
    }
}
