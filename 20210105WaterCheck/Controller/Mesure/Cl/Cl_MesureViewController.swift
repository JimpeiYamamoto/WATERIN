//
//  Cal_MesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/10/18.
//

import UIKit
import AVFoundation
/*
 Clの試験紙を撮影する用のViewControllerになります。
 */
class Cal_MesureViewController: UIViewController, AVCaptureDelegate
{

    var t_info = take_info()
    var ref_rgb_1 = [String:[Double]]()
    let avCapture = AVCapture()
    var stillImageOutput: AVCapturePhotoOutput?
    
    @IBOutlet weak var full_v: UIView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var take_button: UIButton!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta: UIView!
    
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
    
    func target_rgb_get() -> [String:[Double]]
    {
        let image = image_view.image!
        let resize_image = image.resize(width_size: full_v.frame.size.width, height_size: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.05308057
        let paper_rgb = rgb.RGB_lst(image: resize_image!, x: Double(x_) * 8.82142857, y: Double(x_) * 8.69642857, width: Double(x_) * 1, height: Double(x_) * 1)
        print("---target_rgb---")
        print("r1:\(paper_rgb[0])\ng1:\(paper_rgb[1])\nb1:\(paper_rgb[2])")
        return (["paper_rgb":paper_rgb])
    }
    
    @IBAction func take_action(_ sender: Any)
    {
        let CloutVC = (storyboard?.instantiateViewController(identifier: "Cl_check_"))! as Cl_CheckViewController
        CloutVC.t_info = self.t_info
        CloutVC.ref_rgb_1 = ref_rgb_1
//        outVC.target_rgb = target_rgb_get()
//        CloutVC.t_info.target_rgb = target_rgb_get()
        CloutVC.t_info.target_rgb = [[0.1, 0.1], [0.1 ,0.1]]
        //撮影した写真を渡す
        CloutVC.takenImage = image_view.image!
        self.navigationController?.pushViewController(CloutVC, animated: true)
        avCapture.stopSession()
    }
    
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.05308057
        paper_v.frame = CGRect(x: x_ * 8.82142857, y: x_ * 8.69642857, width: x_ * 1, height: x_ * 9.223300971)
        ta.frame = CGRect(x: x_ * 8.82142857, y: x_ * 8.69642857, width: x_ * 1, height: x_ * 1)
        paper_v.layer.borderColor = UIColor.black.cgColor
        paper_v.backgroundColor = .clear
        paper_v.layer.borderWidth = 2
        ta.layer.borderColor = UIColor.black.cgColor
        ta.backgroundColor = .clear
        ta.layer.borderWidth = 2
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
