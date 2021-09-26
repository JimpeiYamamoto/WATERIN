//
//  Mesure_ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit
import AVFoundation

class Mesure_ViewController: UIViewController, AVCaptureDelegate
{
    var t_info = take_info()
    var ref_rgb_1 = [String:[Double]]()
    var ref_rgb_2 = [String:[Double]]()
    
    let avCapture = AVCapture()
    var stillImageOutput: AVCapturePhotoOutput?
    
    @IBOutlet weak var full_v: UIView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var take_button: UIButton!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta_1: UIView!
    @IBOutlet weak var ta_2: UIView!
    @IBOutlet weak var ta_3: UIView!
    @IBOutlet weak var ta_4: UIView!
    
    var rgb = RGB()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
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
    
    func capture(image: UIImage)
    {
        image_view.contentMode = .scaleAspectFit
        image_view.image = image
    }
    
    func target_rgb_get() -> [Double]
    {
        let image = image_view.image!
        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.08985782
        let paper_rgb = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 4.621359223, y: Double(x_) * 5.854368932, width: Double(x_) * 1, height: Double(x_) * 0.902912621)
        print("---target_rgb---")
        print("r:\(paper_rgb[0])\ng:\(paper_rgb[1])\nb:\(paper_rgb[2])")
        return (paper_rgb)
    }
    
    @IBAction func take_action(_ sender: Any)
    {
        let outVC = (storyboard?.instantiateViewController(identifier: "check_"))! as CheckPicViewController
        outVC.t_info = self.t_info
        outVC.ref_rgb_1 = ref_rgb_1
        outVC.ref_rgb_2 = ref_rgb_2
        outVC.target_rgb = target_rgb_get()
        //撮影した写真を渡す
        outVC.takenImage = image_view.image!
        self.navigationController?.pushViewController(outVC, animated: true)
        avCapture.stopSession()
    }
    
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
//        let x_ = full_v.frame.size.width * 0.072985782
        let x_ = full_v.frame.size.width * 0.08985782
        paper_v.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.165048544, width: x_ * 1, height: x_ * 9.223300971)
        ta_1.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.504854369, width: x_ * 1, height: x_ * 0.902912621)
        ta_2.frame = CGRect(x: x_ * 4.621359223, y: x_ * 5.854368932, width: x_ * 1, height: x_ * 0.902912621)
        ta_3.frame = CGRect(x: x_ * 4.621359223, y: x_ * 7.242718447, width: x_ * 1, height: x_ * 0.902912621)
        ta_4.frame = CGRect(x: x_ * 4.621359223, y: x_ * 8.563106796, width: x_ * 1, height: x_ * 0.902912621)
        paper_v.layer.borderColor = UIColor.black.cgColor
        paper_v.backgroundColor = .clear
        paper_v.layer.borderWidth = 2
        ta_1.layer.borderColor = UIColor.black.cgColor
        ta_1.backgroundColor = .clear
        ta_1.layer.borderWidth = 2
        ta_2.layer.borderColor = UIColor.black.cgColor
        ta_2.backgroundColor = .clear
        ta_2.layer.borderWidth = 2
        ta_3.layer.borderColor = UIColor.black.cgColor
        ta_3.backgroundColor = .clear
        ta_3.layer.borderWidth = 2
        ta_4.layer.borderColor = UIColor.black.cgColor
        ta_4.backgroundColor = .clear
        ta_4.layer.borderWidth = 2
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
    
    
}
