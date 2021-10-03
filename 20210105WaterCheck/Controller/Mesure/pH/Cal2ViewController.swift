//
//  Cal2ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit
import AVFoundation

class Cal2ViewController: UIViewController, AVCaptureDelegate
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
    var ref_rgb_1 = [String:[Double]]()
    var rgb = RGB()
    let avCapture = AVCapture()
    var stillImageOutput: AVCapturePhotoOutput?
    
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
        let viewWidth = view.frame.size.width / 100
        let viewHeight = view.frame.size.height / 100
        take_button.frame = CGRect(x: viewWidth * 35, y: viewHeight * 75, width: viewWidth * 30, height: viewHeight * 20)
        take_button.imageView?.contentMode = .scaleAspectFit
        take_button.contentHorizontalAlignment = .fill
        take_button.contentVerticalAlignment = .fill
    }
    
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
    
    func ref_rgb_get() -> [String:[Double]]
    {
        let image = imageView.image!
        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.072985782
        let y1_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        
        let y2_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        
        let y3_14 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_13 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_12 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_11 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_10 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_9 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_8 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        print("---y_14---")
        print("r1:\(y1_14[0])\ng1:\(y1_14[1])\nb1:\(y1_14[2])")
        print("r2:\(y2_14[0])\ng2:\(y2_14[1])\nb2:\(y2_14[2])")
        print("r3:\(y3_14[0])\ng3:\(y3_14[1])\nb3:\(y3_14[2])")
        print("---y_13---")
        print("r1:\(y1_13[0])\ng1:\(y1_13[1])\nb1:\(y1_13[2])")
        print("r2:\(y2_13[0])\ng2:\(y2_13[1])\nb2:\(y2_13[2])")
        print("r3:\(y3_13[0])\ng3:\(y3_13[1])\nb3:\(y3_13[2])")
        print("---y_12---")
        print("r1:\(y1_12[0])\ng1:\(y1_12[1])\nb1:\(y1_12[2])")
        print("r2:\(y2_12[0])\ng2:\(y2_12[1])\nb2:\(y2_12[2])")
        print("r3:\(y3_12[0])\ng3:\(y3_12[1])\nb3:\(y3_12[2])")
        print("---y_11---")
        print("r1:\(y1_11[0])\ng1:\(y1_11[1])\nb1:\(y1_11[2])")
        print("r2:\(y2_11[0])\ng2:\(y2_11[1])\nb2:\(y2_11[2])")
        print("r3:\(y3_11[0])\ng3:\(y3_11[1])\nb3:\(y3_11[2])")
        print("---y_10---")
        print("r1:\(y1_10[0])\ng1:\(y1_10[1])\nb1:\(y1_10[2])")
        print("r2:\(y2_10[0])\ng2:\(y2_10[1])\nb2:\(y2_10[2])")
        print("r3:\(y3_10[0])\ng3:\(y3_10[1])\nb3:\(y3_10[2])")
        print("---y_9---")
        print("r1:\(y1_9[0])\ng1:\(y1_9[1])\nb1:\(y1_9[2])")
        print("r2:\(y2_9[0])\ng2:\(y2_9[1])\nb2:\(y2_9[2])")
        print("r3:\(y3_9[0])\ng3:\(y3_9[1])\nb3:\(y3_9[2])")
        print("---y_8---")
        print("r1:\(y1_8[0])\ng1:\(y1_8[1])\nb1:\(y1_8[2])")
        print("r2:\(y2_8[0])\ng2:\(y2_8[1])\nb2:\(y2_8[2])")
        print("r3:\(y3_8[0])\ng3:\(y3_8[1])\nb3:\(y3_8[2])")
        print("---y_7---")
        print("r1:\(y1_7[0])\ng1:\(y1_7[1])\nb1:\(y1_7[2])")
        print("r2:\(y2_7[0])\ng2:\(y2_7[1])\nb2:\(y2_7[2])")
        print("r3:\(y3_7[0])\ng3:\(y3_7[1])\nb3:\(y3_7[2])")
        return (["y1_14":y1_14, "y1_13":y1_13, "y1_12":y1_12, "y1_11":y1_11, "y1_10":y1_10, "y1_9":y1_9, "y1_8":y1_8, "y1_7":y1_7,
                 "y2_14":y2_14, "y2_13":y2_13, "y2_12":y2_12, "y2_11":y2_11, "y2_10":y2_10, "y2_9":y2_9, "y2_8":y2_8, "y2_7":y2_7,
                 "y3_14":y3_14, "y3_13":y3_13, "y3_12":y3_12, "y3_11":y3_11, "y3_10":y3_10, "y3_9":y3_9, "y3_8":y3_8, "y3_7":y3_7])
    }
    
    func ref_set_v()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        imageView.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.072985782
        v_0_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 5.454545455, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_0_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
        v_0_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
        v_0_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
        v_0_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
        l_7.frame = CGRect(x: x_ * 2.5, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
        
        v_1_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 7.038961039, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_1_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
        v_1_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
        v_1_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
        v_1_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
        l_6.frame = CGRect(x: x_ * 2.5, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
        
        v_2_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 8.61038961, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_2_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
        v_2_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
        v_2_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
        v_2_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
        l_5.frame = CGRect(x: x_ * 2.5, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
        
        v_3_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 10.16883117, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_3_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
        v_3_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
        v_3_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
        v_3_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
        l_4.frame = CGRect(x: x_ * 2.5, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
        
        v_4_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 11.71428571, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_4_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
        v_4_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
        v_4_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
        v_4_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
        l_3.frame = CGRect(x: x_ * 2.5, y:x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
        
        v_5_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 13.27272727, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_5_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
        v_5_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
        v_5_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
        v_5_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
        l_2.frame = CGRect(x: x_ * 2.5, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
        
        v_6_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 14.81818182, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_6_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
        v_6_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
        v_6_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
        v_6_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
        l_1.frame = CGRect(x: x_ * 2.5, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
        
        v_7_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 16.36363636, width: x_ * 6.376623377, height: x_ * 1.194805195)
        v_7_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
        v_7_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
        v_7_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
        v_7_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
        l_0.frame = CGRect(x: x_ * 2.5, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
    }
    
    @IBAction func take_action(_ sender: Any)
    {
        let mesure_vc = storyboard?.instantiateViewController(identifier: "mesure_") as! Mesure_ViewController
        mesure_vc.t_info = self.t_info
        mesure_vc.t_info.ref2_image = imageView.image
        mesure_vc.ref_rgb_1 = ref_rgb_1
        mesure_vc.ref_rgb_2 = ref_rgb_get()
        self.navigationController?.pushViewController(mesure_vc, animated: true)
    }
    
    func ref_color_set()
    {
        v_0_0.layer.borderColor = UIColor.black.cgColor
        v_0_0.backgroundColor = .clear
        v_0_0.layer.borderWidth = 2
        v_0_1.layer.borderColor = UIColor.black.cgColor
        v_0_1.backgroundColor = .clear
        v_0_1.layer.borderWidth = 2
        v_0_2.layer.borderColor = UIColor.black.cgColor
        v_0_2.backgroundColor = .clear
        v_0_2.layer.borderWidth = 2
        v_0_3.layer.borderColor = UIColor.black.cgColor
        v_0_3.backgroundColor = .clear
        v_0_3.layer.borderWidth = 2
        v_0_4.layer.borderColor = UIColor.black.cgColor
        v_0_4.backgroundColor = .clear
        v_0_4.layer.borderWidth = 2
        
        v_1_0.layer.borderColor = UIColor.black.cgColor
        v_1_0.backgroundColor = .clear
        v_1_0.layer.borderWidth = 2
        v_1_1.layer.borderColor = UIColor.black.cgColor
        v_1_1.backgroundColor = .clear
        v_1_1.layer.borderWidth = 2
        v_1_2.layer.borderColor = UIColor.black.cgColor
        v_1_2.backgroundColor = .clear
        v_1_2.layer.borderWidth = 2
        v_1_3.layer.borderColor = UIColor.black.cgColor
        v_1_3.backgroundColor = .clear
        v_1_3.layer.borderWidth = 2
        v_1_4.layer.borderColor = UIColor.black.cgColor
        v_1_4.backgroundColor = .clear
        v_1_4.layer.borderWidth = 2
        
        v_2_0.layer.borderColor = UIColor.black.cgColor
        v_2_0.backgroundColor = .clear
        v_2_0.layer.borderWidth = 2
        v_2_1.layer.borderColor = UIColor.black.cgColor
        v_2_1.backgroundColor = .clear
        v_2_1.layer.borderWidth = 2
        v_2_2.layer.borderColor = UIColor.black.cgColor
        v_2_2.backgroundColor = .clear
        v_2_2.layer.borderWidth = 2
        v_2_3.layer.borderColor = UIColor.black.cgColor
        v_2_3.backgroundColor = .clear
        v_2_3.layer.borderWidth = 2
        v_2_4.layer.borderColor = UIColor.black.cgColor
        v_2_4.backgroundColor = .clear
        v_2_4.layer.borderWidth = 2
        
        v_3_0.layer.borderColor = UIColor.black.cgColor
        v_3_0.backgroundColor = .clear
        v_3_0.layer.borderWidth = 2
        v_3_1.layer.borderColor = UIColor.black.cgColor
        v_3_1.backgroundColor = .clear
        v_3_1.layer.borderWidth = 2
        v_3_2.layer.borderColor = UIColor.black.cgColor
        v_3_2.backgroundColor = .clear
        v_3_2.layer.borderWidth = 2
        v_3_3.layer.borderColor = UIColor.black.cgColor
        v_3_3.backgroundColor = .clear
        v_3_3.layer.borderWidth = 2
        v_3_4.layer.borderColor = UIColor.black.cgColor
        v_3_4.backgroundColor = .clear
        v_3_4.layer.borderWidth = 2
        
        v_4_0.layer.borderColor = UIColor.black.cgColor
        v_4_0.backgroundColor = .clear
        v_4_0.layer.borderWidth = 2
        v_4_1.layer.borderColor = UIColor.black.cgColor
        v_4_1.backgroundColor = .clear
        v_4_1.layer.borderWidth = 2
        v_4_2.layer.borderColor = UIColor.black.cgColor
        v_4_2.backgroundColor = .clear
        v_4_2.layer.borderWidth = 2
        v_4_3.layer.borderColor = UIColor.black.cgColor
        v_4_3.backgroundColor = .clear
        v_4_3.layer.borderWidth = 2
        v_4_4.layer.borderColor = UIColor.black.cgColor
        v_4_4.backgroundColor = .clear
        v_4_4.layer.borderWidth = 2
        
        v_5_0.layer.borderColor = UIColor.black.cgColor
        v_5_0.backgroundColor = .clear
        v_5_0.layer.borderWidth = 2
        v_5_1.layer.borderColor = UIColor.black.cgColor
        v_5_1.backgroundColor = .clear
        v_5_1.layer.borderWidth = 2
        v_5_2.layer.borderColor = UIColor.black.cgColor
        v_5_2.backgroundColor = .clear
        v_5_2.layer.borderWidth = 2
        v_5_3.layer.borderColor = UIColor.black.cgColor
        v_5_3.backgroundColor = .clear
        v_5_3.layer.borderWidth = 2
        v_5_4.layer.borderColor = UIColor.black.cgColor
        v_5_4.backgroundColor = .clear
        v_5_4.layer.borderWidth = 2
        
        v_6_0.layer.borderColor = UIColor.black.cgColor
        v_6_0.backgroundColor = .clear
        v_6_0.layer.borderWidth = 2
        v_6_1.layer.borderColor = UIColor.black.cgColor
        v_6_1.backgroundColor = .clear
        v_6_1.layer.borderWidth = 2
        v_6_2.layer.borderColor = UIColor.black.cgColor
        v_6_2.backgroundColor = .clear
        v_6_2.layer.borderWidth = 2
        v_6_3.layer.borderColor = UIColor.black.cgColor
        v_6_3.backgroundColor = .clear
        v_6_3.layer.borderWidth = 2
        v_6_4.layer.borderColor = UIColor.black.cgColor
        v_6_4.backgroundColor = .clear
        v_6_4.layer.borderWidth = 2
        
        v_7_0.layer.borderColor = UIColor.black.cgColor
        v_7_0.backgroundColor = .clear
        v_7_0.layer.borderWidth = 2
        v_7_1.layer.borderColor = UIColor.black.cgColor
        v_7_1.backgroundColor = .clear
        v_7_1.layer.borderWidth = 2
        v_7_2.layer.borderColor = UIColor.black.cgColor
        v_7_2.backgroundColor = .clear
        v_7_2.layer.borderWidth = 2
        v_7_3.layer.borderColor = UIColor.black.cgColor
        v_7_3.backgroundColor = .clear
        v_7_3.layer.borderWidth = 2
        v_7_4.layer.borderColor = UIColor.black.cgColor
        v_7_4.backgroundColor = .clear
        v_7_4.layer.borderWidth = 2
    }
    
}
