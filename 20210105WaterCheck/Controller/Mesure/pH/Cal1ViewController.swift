//
//  MesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import AVFoundation

class Cal1ViewController: UIViewController, AVCaptureDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takeButton: UIButton!
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
    
    var rgb = RGB()
    var t_info = take_info()
    let avCapture = AVCapture()
    var stillImageOutput: AVCapturePhotoOutput?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref_color_set()
        //ref_place_set()
        ref_set_v()
        viewSetting()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
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
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        avCapture.stopSession()
    }
    
    var loop_num = 0
    func capture(image: UIImage)
    {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        loop_num += 1
    }

    @IBAction func takeAction(_ sender: Any)
    {
        let checkVC = (storyboard?.instantiateViewController(identifier: "cal2"))! as Cal2ViewController
        checkVC.t_info = self.t_info
        checkVC.ref_rgb_1 = ref_rgb_get()
        avCapture.delegate = nil
        avCapture.stopSession()
        self.navigationController?.pushViewController(checkVC, animated: true)
    }
    
    func ref_rgb_get() -> [String:[Double]]
    {
        let image = imageView.image!
        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.072985782
        let y1_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_6 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_5 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_4 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_3 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_2 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_1 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y1_0 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.155844156, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        
        let y2_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_6 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_5 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_4 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_3 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_2 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_1 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y2_0 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 5.649350649, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        
        let y3_7 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 5.454545455, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_6 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 7.038961039, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_5 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 8.61038961, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_4 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 10.16883117, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_3 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 11.71428571, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_2 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 13.27272727, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_1 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 14.81818182, width: Double(x_), height: Double(x_) * 1.194805195)
        let y3_0 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 7.142857143, y: Double(x_) * 16.36363636, width: Double(x_), height: Double(x_) * 1.194805195)
        print("---y_0---")
        print("r:\(y2_0[0])\ng:\(y2_0[1])\nb:\(y2_0[2])")
        print("---y_1---")
        print("r:\(y2_1[0])\ng:\(y2_1[1])\nb:\(y2_1[2])")
        print("---y_2---")
        print("r:\(y2_2[0])\ng:\(y2_2[1])\nb:\(y2_2[2])")
        print("---y_3---")
        print("r:\(y2_3[0])\ng:\(y2_3[1])\nb:\(y2_3[2])")
        print("---y_4---")
        print("r:\(y2_4[0])\ng:\(y2_4[1])\nb:\(y2_4[2])")
        print("---y_5---")
        print("r:\(y2_5[0])\ng:\(y2_5[1])\nb:\(y2_5[2])")
        print("---y_6---")
        print("r:\(y2_6[0])\ng:\(y2_6[1])\nb:\(y2_6[2])")
        print("---y_7---")
        print("r:\(y2_7[0])\ng:\(y2_7[1])\nb:\(y2_7[2])")
        return (["y1_0":y1_0, "y1_1":y1_1, "y1_2":y1_2, "y1_3":y1_3, "y1_4":y1_4, "y1_5":y1_5, "y1_6":y1_6, "y1_7":y1_7,
                 "y2_0":y2_0, "y2_1":y2_1, "y2_2":y2_2, "y2_3":y2_3, "y2_4":y2_4, "y2_5":y2_5, "y2_6":y2_6, "y2_7":y2_7,
                 "y3_0":y3_0, "y3_1":y3_1, "y3_2":y3_2, "y3_3":y3_3, "y3_4":y3_4, "y3_5":y3_5, "y3_6":y3_6, "y3_7":y3_7])
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

    func viewSetting()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.tabBarController?.tabBar.isHidden = true
        let viewWidth = view.frame.size.width / 100
        let viewHeight = view.frame.size.height / 100
        takeButton.frame = CGRect(x: viewWidth * 35, y: viewHeight * 75, width: viewWidth * 30, height: viewHeight * 20)
        takeButton.layer.cornerRadius = 20.0
        takeButton.imageView?.contentMode = .scaleAspectFit
        takeButton.contentHorizontalAlignment = .fill
        takeButton.contentVerticalAlignment = .fill
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
