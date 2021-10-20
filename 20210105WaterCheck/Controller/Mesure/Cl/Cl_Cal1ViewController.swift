//
//  Cl_Cal1ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/10/18.
//

import UIKit
import AVFoundation
/*
 このviewControllerには校正用で塩素試験紙のボトルの写真を取る部分の
 実装をしてください。
 */
class Cl_Cal1ViewController: UIViewController, AVCaptureDelegate
{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var full_v: UIView!
    

    @IBOutlet weak var v_0: UIView!
    @IBOutlet weak var v_1: UIView!
    @IBOutlet weak var v_2: UIView!
    @IBOutlet weak var v_3: UIView!
    @IBOutlet weak var v_4: UIView!
    @IBOutlet weak var v_5: UIView!
    
    @IBOutlet weak var l_0: UILabel!
    @IBOutlet weak var l_1: UILabel!
    @IBOutlet weak var l_2: UILabel!
    @IBOutlet weak var l_3: UILabel!
    @IBOutlet weak var l_4: UILabel!
    @IBOutlet weak var l_5: UILabel!
    
    
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
        let ClcheckVC = (storyboard?.instantiateViewController(identifier: "Cl_mesure_"))! as Cal_MesureViewController
        ClcheckVC.t_info = self.t_info
        ClcheckVC.ref_rgb_1 = ref_rgb_get()
        ClcheckVC.t_info.ref1_image = imageView.image
        if (ClcheckVC.ref_rgb_1["y2"]![2] >= 80.0)
        {
            let alertSheet = UIAlertController(title: "【注意】強い光が当たっています", message: "正しい結果が得られない恐れがあります", preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "続ける", style: UIAlertAction.Style.default, handler:
            { [] (action: UIAlertAction!) in
                //ここに処理を書いていく
                self.avCapture.delegate = nil
                self.avCapture.stopSession()
                self.navigationController?.pushViewController(ClcheckVC, animated: true)
            })
            let action2 = UIAlertAction(title: "やり直す", style: UIAlertAction.Style.destructive, handler:
            { [] (action: UIAlertAction!) in
            })
            alertSheet.addAction(action1)
            alertSheet.addAction(action2)
            self.present(alertSheet, animated: true, completion: nil)
        }
        else
        {
            self.avCapture.delegate = nil
            self.avCapture.stopSession()
            self.navigationController?.pushViewController(ClcheckVC, animated: true)
        }
    }
    
    func ref_rgb_get() -> [String:[Double]]
    {
        let image = imageView.image!
        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.39339623
        let y5 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 1.70983213, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        let y4 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 1.96402878, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        let y3 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 2.23741007, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        let y2 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 2.52757794, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        let y1 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 2.8177458, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        let y0 = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 1.15587529, y: Double(x_) * 3.10551559, width: Double(x_) * 0.21582734, height: Double(x_) * 0.20863309)
        
        
        print("---y_0---")
        print("r1:\(y0[0])\ng1:\(y0[1])\nb1:\(y0[2])")
        print("---y_1---")
        print("r1:\(y1[0])\ng1:\(y1[1])\nb1:\(y1[2])")
        print("---y_2---")
        print("r1:\(y2[0])\ng1:\(y2[1])\nb1:\(y2[2])")
        print("---y_3---")
        print("r1:\(y3[0])\ng1:\(y3[1])\nb1:\(y3[2])")
        print("---y_4---")
        print("r1:\(y4[0])\ng1:\(y4[1])\nb1:\(y4[2])")
        print("---y_5---")
        print("r1:\(y5[0])\ng1:\(y5[1])\nb1:\(y5[2])")
        return (["y0":y0, "y1":y1, "y2":y2, "y3":y3, "y4":y4, "y5":y5])
    }
    

    func ref_set_v()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        imageView.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.39339623
        v_0.frame = CGRect(x: x_ * 1.15587529, y: x_ * 3.10551559, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_0.frame = CGRect(x: x_ * 0.9000000, y: x_ * 3.10551559, width: x_ * 0.21582734_, height: x_ * 0.20863309)
        v_1.frame = CGRect(x: x_ * 1.15587529, y: x_ * 2.8177458, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_1.frame = CGRect(x: x_ * 0.9000000, y: x_ * 2.8177458, width: x_ * 0.21582734, height: x_ * 0.20863309)
        v_2.frame = CGRect(x: x_ * 1.15587529, y: x_ * 2.52757794, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_2.frame = CGRect(x: x_ * 0.9000000, y: x_ * 2.52757794, width: x_ * 0.21582734, height: x_ * 0.20863309)
        v_3.frame = CGRect(x: x_ * 1.15587529, y: x_ * 2.23741007, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_3.frame = CGRect(x: x_ * 0.9000000, y: x_ * 2.23741007, width: x_ * 0.21582734, height: x_ * 0.20863309)
        v_4.frame = CGRect(x: x_ * 1.15587529, y: x_ * 1.96402878, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_4.frame = CGRect(x: x_ * 0.9000000, y:x_ * 1.96402878, width: x_ * 0.21582734, height: x_ * 0.20863309)
        v_5.frame = CGRect(x: x_ * 1.15587529, y: x_ * 1.70983213, width: x_ * 0.21582734, height: x_ * 0.20863309)
        l_5.frame = CGRect(x: x_ * 0.9000000, y: x_ * 1.70983213, width: x_ * 0.21582734, height: x_ * 0.20863309)
        
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
        v_0.layer.borderColor = UIColor.black.cgColor
        v_0.backgroundColor = .clear
        v_0.layer.borderWidth = 2
        v_1.layer.borderColor = UIColor.black.cgColor
        v_1.backgroundColor = .clear
        v_1.layer.borderWidth = 2
        v_2.layer.borderColor = UIColor.black.cgColor
        v_2.backgroundColor = .clear
        v_2.layer.borderWidth = 2
        v_3.layer.borderColor = UIColor.black.cgColor
        v_3.backgroundColor = .clear
        v_3.layer.borderWidth = 2
        v_4.layer.borderColor = UIColor.black.cgColor
        v_4.backgroundColor = .clear
        v_4.layer.borderWidth = 2
        v_5.layer.borderColor = UIColor.black.cgColor
        v_5.backgroundColor = .clear
        v_5.layer.borderWidth = 2

    }
}
