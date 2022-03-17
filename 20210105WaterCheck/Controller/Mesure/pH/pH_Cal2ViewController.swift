//
//  Cal2ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit
import AVFoundation

class pH_Cal2ViewController: UIViewController, AVCaptureDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var take_button: UIButton!
    @IBOutlet weak var full_v: UIView!
    
    @IBOutlet weak var v_0_0: UIView!
    @IBOutlet weak var v_0_1: UIView!
    @IBOutlet weak var v_0_2: UIView!
    @IBOutlet weak var v_0_3: UIView!
    @IBOutlet weak var v_0_4: UIView!
    
    @IBOutlet weak var v_1_0: UIView!
    @IBOutlet weak var v_1_1: UIView!
    @IBOutlet weak var v_1_2: UIView!
    @IBOutlet weak var v_1_3: UIView!
    @IBOutlet weak var v_1_4: UIView!
    
    @IBOutlet weak var v_2_0: UIView!
    @IBOutlet weak var v_2_1: UIView!
    @IBOutlet weak var v_2_2: UIView!
    @IBOutlet weak var v_2_3: UIView!
    @IBOutlet weak var v_2_4: UIView!
    
    @IBOutlet weak var v_3_0: UIView!
    @IBOutlet weak var v_3_1: UIView!
    @IBOutlet weak var v_3_2: UIView!
    @IBOutlet weak var v_3_3: UIView!
    @IBOutlet weak var v_3_4: UIView!
    
    @IBOutlet weak var v_4_0: UIView!
    @IBOutlet weak var v_4_1: UIView!
    @IBOutlet weak var v_4_2: UIView!
    @IBOutlet weak var v_4_3: UIView!
    @IBOutlet weak var v_4_4: UIView!
    
    @IBOutlet weak var v_5_0: UIView!
    @IBOutlet weak var v_5_1: UIView!
    @IBOutlet weak var v_5_2: UIView!
    @IBOutlet weak var v_5_3: UIView!
    @IBOutlet weak var v_5_4: UIView!
    
    @IBOutlet weak var v_6_0: UIView!
    @IBOutlet weak var v_6_1: UIView!
    @IBOutlet weak var v_6_2: UIView!
    @IBOutlet weak var v_6_3: UIView!
    @IBOutlet weak var v_6_4: UIView!
    
    @IBOutlet weak var v_7_0: UIView!
    @IBOutlet weak var v_7_1: UIView!
    @IBOutlet weak var v_7_2: UIView!
    @IBOutlet weak var v_7_3: UIView!
    @IBOutlet weak var v_7_4: UIView!
    
    @IBOutlet weak var l_7: UILabel!
    @IBOutlet weak var l_6: UILabel!
    @IBOutlet weak var l_5: UILabel!
    @IBOutlet weak var l_4: UILabel!
    @IBOutlet weak var l_3: UILabel!
    @IBOutlet weak var l_2: UILabel!
    @IBOutlet weak var l_1: UILabel!
    @IBOutlet weak var l_0: UILabel!
    
    var t_info = take_info()
    var pH_Class = pH_class()
    let avCapture = AVCapture()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
        ref_set_v()
        ref_color_set()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        avCapture.stopSession()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        view.isUserInteractionEnabled = false
        avCapture.delegate = self
        avCapture.start_session()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        sleep(1)
        view.isUserInteractionEnabled = true
    }
    
    func capture(image: UIImage)
    {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
    }
    
//    func ref_rgb_get() -> [String:[Double]]
//    {
//        let image = imageView.image!
//        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
//        let x_ = full_v.frame.size.width * 0.072985782
//        let y1_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y1_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
//
//        let y2_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y2_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
//
//        let y3_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
//        let y3_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
//        print("---y_14---")
//        print("r1:\(y1_14[0])\ng1:\(y1_14[1])\nb1:\(y1_14[2])")
//        print("r2:\(y2_14[0])\ng2:\(y2_14[1])\nb2:\(y2_14[2])")
//        print("r3:\(y3_14[0])\ng3:\(y3_14[1])\nb3:\(y3_14[2])")
//        print("---y_13---")
//        print("r1:\(y1_13[0])\ng1:\(y1_13[1])\nb1:\(y1_13[2])")
//        print("r2:\(y2_13[0])\ng2:\(y2_13[1])\nb2:\(y2_13[2])")
//        print("r3:\(y3_13[0])\ng3:\(y3_13[1])\nb3:\(y3_13[2])")
//        print("---y_12---")
//        print("r1:\(y1_12[0])\ng1:\(y1_12[1])\nb1:\(y1_12[2])")
//        print("r2:\(y2_12[0])\ng2:\(y2_12[1])\nb2:\(y2_12[2])")
//        print("r3:\(y3_12[0])\ng3:\(y3_12[1])\nb3:\(y3_12[2])")
//        print("---y_11---")
//        print("r1:\(y1_11[0])\ng1:\(y1_11[1])\nb1:\(y1_11[2])")
//        print("r2:\(y2_11[0])\ng2:\(y2_11[1])\nb2:\(y2_11[2])")
//        print("r3:\(y3_11[0])\ng3:\(y3_11[1])\nb3:\(y3_11[2])")
//        print("---y_10---")
//        print("r1:\(y1_10[0])\ng1:\(y1_10[1])\nb1:\(y1_10[2])")
//        print("r2:\(y2_10[0])\ng2:\(y2_10[1])\nb2:\(y2_10[2])")
//        print("r3:\(y3_10[0])\ng3:\(y3_10[1])\nb3:\(y3_10[2])")
//        print("---y_9---")
//        print("r1:\(y1_9[0])\ng1:\(y1_9[1])\nb1:\(y1_9[2])")
//        print("r2:\(y2_9[0])\ng2:\(y2_9[1])\nb2:\(y2_9[2])")
//        print("r3:\(y3_9[0])\ng3:\(y3_9[1])\nb3:\(y3_9[2])")
//        print("---y_8---")
//        print("r1:\(y1_8[0])\ng1:\(y1_8[1])\nb1:\(y1_8[2])")
//        print("r2:\(y2_8[0])\ng2:\(y2_8[1])\nb2:\(y2_8[2])")
//        print("r3:\(y3_8[0])\ng3:\(y3_8[1])\nb3:\(y3_8[2])")
//        print("---y_7---")
//        print("r1:\(y1_7[0])\ng1:\(y1_7[1])\nb1:\(y1_7[2])")
//        print("r2:\(y2_7[0])\ng2:\(y2_7[1])\nb2:\(y2_7[2])")
//        print("r3:\(y3_7[0])\ng3:\(y3_7[1])\nb3:\(y3_7[2])")
//        return (["y1_14":y1_14, "y1_13":y1_13, "y1_12":y1_12, "y1_11":y1_11,
//                 "y1_10":y1_10, "y1_9":y1_9, "y1_8":y1_8, "y1_7":y1_7,
//                 "y2_14":y2_14, "y2_13":y2_13, "y2_12":y2_12, "y2_11":y2_11,
//                 "y2_10":y2_10, "y2_9":y2_9, "y2_8":y2_8, "y2_7":y2_7,
//                 "y3_14":y3_14, "y3_13":y3_13, "y3_12":y3_12, "y3_11":y3_11,
//                 "y3_10":y3_10, "y3_9":y3_9, "y3_8":y3_8, "y3_7":y3_7])
//    }
//
    
    @IBAction func take_action(_ sender: Any)
    {
        let mesure_vc = storyboard?.instantiateViewController(identifier: "mesure_") as! pH_Mesure_ViewController
        mesure_vc.t_info = self.t_info
        mesure_vc.t_info.ref2_rgb = pH_Class.ref_rgb_get(image: imageView.image!,
                                                         full_v_width: full_v.frame.size.width,
                                                         full_v_height: full_v.frame.size.height)
        mesure_vc.t_info.ref2_image = imageView.image
        self.navigationController?.pushViewController(mesure_vc, animated: true)
    }
}
